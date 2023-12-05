import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:redback_mobile_app/Models/workout_stats.dart';
import 'package:redback_mobile_app/Utils/constants.dart' as constants;
import 'package:redback_mobile_app/Utils/shared_prefs_util.dart';
import 'package:redback_mobile_app/Workout/end_screen.dart';
import 'package:redback_mobile_app/Utils/size_config.dart';

class MidWorkout extends StatelessWidget {
  const MidWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MidWorkoutState(),
    );
  }
}

class MidWorkoutState extends StatefulWidget {
  const MidWorkoutState({Key? key}) : super(key: key);

  @override
  State<MidWorkoutState> createState() => _MidWorkoutState();
}

class _MidWorkoutState extends State<MidWorkoutState> {
  late int level = 1;
  late int downTime = 5;
  late int timingNumber = 0;
  late Timer dTimer;
  late String timeElapsed = "00:00:00";

  double currentSpeed = 0.0;
  double currentCadence = 0.0;
  int currentHeartRate = 0;
  int currentPower = 0;
  int currentFanSpeed = 0;

  WorkoutStats stats = WorkoutStats();
  bool lastScannedQRCodeExists = SharedPrefsUtil.getLastScannedBikeId() != null;

  MqttServerClient? mqttClient; // Connection to HiveMQ MQTT broker
  Future<void>?
      connectionAttempt; // reference to connection thread should we need to ignore its result

  @override
  void initState() {
    super.initState();

    dTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (downTime > 0) {
        setState(() {
          downTime--;
        });
      } else {
        if (timingNumber >= 0) {
          setState(() {
            timingNumber++;
          });
        } else {
          debugPrint("Work Finished! ${formatTimeString(timingNumber)}");
          dTimer.cancel();
        }
      }

      // signal to mqtt that the workout has started if the countdown reaches 0
      if (downTime == 0) {
        startWorkout();
        downTime--;
      }
    });

    // check if we scanned a qr code on the bike, release mode enforces this, debug might return null
    // we cannot subscribe to the mqtt topics as we don't have the Bike ID of the bike sensors we want to subscribe to
    if (!lastScannedQRCodeExists) {
      return;
    }

    // initialize the connection to HiveMQ using the stored credentials in another thread
    connectionAttempt = Future.delayed(Duration.zero, () async {
      tryConnect();
    });
  }

  @override
  void dispose() {
    super.dispose();

    // stop the timer
    dTimer.cancel();

    // disconnect from the MQTT client
    mqttClient?.disconnect();

    // cancel the connection attempt if its in progress
    connectionAttempt?.ignore();
  }

  Future<void> tryConnect() async {
    // create the MQTT Client
    MqttServerClient client =
        MqttServerClient.withPort(dotenv.env['MQTT_HOST']!, "redback", 8883);
    client.secure = true;

    // enable logging and set up the lifecycle method handlers
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;

    // connect to the client
    final connMessage = MqttConnectMessage()
        .authenticateAs(
            dotenv.env['MQTT_USERNAME']!, dotenv.env['MQTT_PASSWORD']!)
        .startClean();
    client.connectionMessage = connMessage;

    try {
      await client.connect(
          dotenv.env['MQTT_USERNAME']!, dotenv.env['MQTT_PASSWORD']!);
    } catch (e) {
      debugPrint('Exception: $e');
      client.disconnect();
    }

    // if the connection to MQTT times out and the user has already finished the workout then just return
    if (!mounted) {
      return;
    }

    // we connected to MQTT and this screen is still active
    debugPrint("Connected to HiveMQ");

    // set up message handler
    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.

    // listen to updates if the connection was successful
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        /// The payload is a byte buffer, this will be specific to the topic
        handleMessage(c[0].topic, pt);
      });

      // subscribe to all the mqtt topics for our bike using the wildcard token '#'
      final String topic = "bike/${SharedPrefsUtil.getLastScannedBikeId()}/#";
      client.subscribe(topic, MqttQos.atLeastOnce);
    }

    mqttClient = client;
  }

  String formatTimeString(int value) {
    String minute = (value / 60).floor() >= 10
        ? "${(value / 60).floor()}"
        : "0${(value / 60).floor()}";
    String second = value % 60 >= 10 ? "${value % 60}" : "0${value % 60}";
    return "00:$minute:$second";
  }

  startWorkout() {
    // ensure we have scanned the qr code to send the message over MQTT to start the workout
    if (!lastScannedQRCodeExists) {
      return;
    }

    // signal to mqtt that we are about to start a workout
    String topic = "bike/${SharedPrefsUtil.getLastScannedBikeId()!}/workout";
    String startMessage =
        "{\"command\": \"start\", \"type\": \"${SharedPrefsUtil.getWorkoutType()!}\", \"duration\":\"-1\"}";
    final builder = MqttClientPayloadBuilder().addString(startMessage);
    mqttClient?.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  finishWorkout() {
    // signal to mqtt that we are done with the workout
    if (mqttClient?.connectionStatus?.state == MqttConnectionState.connected) {
      String topic = "bike/${SharedPrefsUtil.getLastScannedBikeId()!}/workout";
      String workoutType = SharedPrefsUtil.getWorkoutType()!;
      String stopMessage = "{\"command\": \"stop\", \"type\":\"$workoutType\"}";
      final builder = MqttClientPayloadBuilder().addString(stopMessage);
      mqttClient?.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    }

    // store the workout details here to show the user
    var workoutLength = formatTimeString(timingNumber);
    debugPrint("Work Finished! $workoutLength");
    stats.workoutLength = workoutLength;

    // transition to the end screen and cancel the timer
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => EndScreen(stats: stats)));
    dTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(181, 79, 92, 1),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(78, 34, 84, 1),
        foregroundColor: Colors.white,
        title: Text(
          constants.workoutNames[SharedPrefsUtil.getWorkoutType()]!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 27,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal! * 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 40,
                                height: SizeConfig.blockSizeVertical! * 10,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Speed",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        color: const Color.fromRGBO(
                                            239, 93, 62, 1),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${currentSpeed.toStringAsFixed(1)} KM/H",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 40,
                                height: SizeConfig.blockSizeVertical! * 10,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Cadence",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        color: const Color.fromRGBO(
                                            239, 93, 62, 1),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${currentCadence.toStringAsFixed(1)} RPM",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal! * 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 40,
                                height: SizeConfig.blockSizeVertical! * 10,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Heart Rate",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        color: const Color.fromRGBO(
                                            239, 93, 62, 1),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "$currentHeartRate BPM",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 40,
                                height: SizeConfig.blockSizeVertical! * 10,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Power",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        color: const Color.fromRGBO(
                                            239, 93, 62, 1),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "$currentPower W",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 3,
                      ),
                      const Text(
                        "Time Elapsed",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 0.5,
                      ),
                      Text(
                        formatTimeString(timingNumber),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 3,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal! * 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 40,
                                height: SizeConfig.blockSizeVertical! * 10,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Fan Speed",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        color: const Color.fromRGBO(
                                            239, 93, 62, 1),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "$currentFanSpeed KM/H",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 40,
                                height: SizeConfig.blockSizeVertical! * 10,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Current Level",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        color: const Color.fromRGBO(
                                            239, 93, 62, 1),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Visibility(
                                                // @formatter:off
                                                visible: SharedPrefsUtil
                                                        .getWorkoutType() !=
                                                    "ramped",
                                                // @formatter:on
                                                maintainSize: true,
                                                maintainAnimation: true,
                                                maintainState: true,
                                                child: InkWell(
                                                  onTap: () {
                                                    if (level > 1) {
                                                      decreaseLevel();
                                                    }
                                                  },
                                                  child: Container(
                                                    width: SizeConfig
                                                            .blockSizeVertical! *
                                                        2.5,
                                                    height: SizeConfig
                                                            .blockSizeVertical! *
                                                        2.5,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                    child: const Text("-"),
                                                  ),
                                                )),
                                            Text(
                                              "$level",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Visibility(
                                              // @formatter:off
                                              visible: SharedPrefsUtil
                                                      .getWorkoutType() !=
                                                  "ramped",
                                              // @formatter:on
                                              maintainSize: true,
                                              maintainAnimation: true,
                                              maintainState: true,
                                              child: InkWell(
                                                onTap: () {
                                                  if (level < 20) {
                                                    increaseLevel();
                                                  }
                                                },
                                                child: Container(
                                                  width: SizeConfig
                                                          .blockSizeVertical! *
                                                      2.5,
                                                  height: SizeConfig
                                                          .blockSizeVertical! *
                                                      2.5,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                  ),
                                                  child: const Text("+"),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: SizeConfig.blockSizeVertical! * 10,
                alignment: Alignment.center,
                color: const Color.fromRGBO(78, 34, 84, 1),
                child: InkWell(
                  onTap: () => finishWorkout(),
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal! * 40,
                    height: SizeConfig.blockSizeVertical! * 5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(239, 93, 62, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Finish Workout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Offstage(
            offstage: downTime <= 0,
            child: Container(
              width: 500,
              height: 1000,
              alignment: Alignment.center,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              child: Container(
                width: 120,
                height: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 230, 152, 129),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  "$downTime",
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 230, 152, 129),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
              backgroundColor: Color.fromARGB(255, 230, 152, 129),
              color: Color.fromARGB(183, 255, 255, 255),
              activeColor: Color.fromARGB(255, 130, 235, 182),
              tabBackgroundColor: Color.fromARGB(55, 114, 243, 153),
              gap: 10,
              padding: EdgeInsets.all(16),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite_rounded,
                  text: 'Friends',
                ),
                GButton(
                  icon: Icons.account_circle_rounded,
                  text: 'Profile',
                ),
              ]),
        ),
      ),
    );
  }

  void handleMessage(String topic, String pt) {
    debugPrint("TOPIC: $topic");
    var topicComponents = topic.split("/");
    debugPrint("DEBUG: ${topicComponents.last}");
    debugPrint("DEBUG: $pt");

    switch (topicComponents.last) {
      case "speed":
        setState(() {
          var value = json.decode(pt)['value'];
          currentSpeed = value;
        });

        if (currentSpeed > stats.maxSpeed) {
          stats.maxSpeed = currentSpeed;
        }
        debugPrint("Message from topic $topic received: $pt");
        break;
      case "cadence":
        setState(() {
          var value = json.decode(pt)['value'];
          currentCadence = value;
        });

        if (currentCadence > stats.maxCadence) {
          stats.maxCadence = currentCadence;
        }
        debugPrint("Message from topic $topic received: $pt");
        break;
      case "power":
        setState(() {
          var value = json.decode(pt)['value'];
          currentPower = value;
        });

        if (currentPower > stats.maxPower) {
          stats.maxPower = currentPower;
        }
        debugPrint("Message from topic $topic received: $pt");
        break;
      case "heartrate":
        setState(() {
          var value = json.decode(pt)['value'];
          currentHeartRate = value;
        });

        if (currentHeartRate > stats.maxHeartRate) {
          stats.maxHeartRate = currentHeartRate;
        }
        debugPrint("Message from topic $topic received: $pt");
        break;
      case "level":
        setState(() {
          var value = json.decode(pt)['value'];
          level = value;
        });

        if (level > stats.maxLevel) {
          stats.maxLevel = level;
        }
        debugPrint("Message from topic $topic received: $pt");
        break;
      case "fan":
        setState(() {
          int value = json.decode(pt)['value'];
          currentFanSpeed =
              (value / 100 * 54).round(); // max fan speed is 54 KM/H;
        });
        debugPrint("Message from topic $topic received: $pt");
        break;
      case "resistance":
        debugPrint("Message from topic $topic received: $pt");
        break;
      case "incline":
        debugPrint("Message from topic $topic received: $pt");
        break;
      default:
        debugPrint("Unknown topic $topic encountered");
    }
  }

  void decreaseLevel() {
    if (mqttClient?.connectionStatus?.state == MqttConnectionState.connected) {
      setState(() {
        level--;
      });

      // ensure we have scanned the qr code to send the message over MQTT
      if (SharedPrefsUtil.getLastScannedBikeId() == null) {
        return;
      }

      // send a message to the workout topic to decrease the difficulty
      String topic = "bike/${SharedPrefsUtil.getLastScannedBikeId()!}/workout";
      String workoutType = SharedPrefsUtil.getWorkoutType()!;
      String stopMessage =
          "{\"command\": \"decrease\", \"type\":\"$workoutType\"}";
      final builder = MqttClientPayloadBuilder().addString(stopMessage);
      mqttClient?.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    }
  }

  void increaseLevel() {
    if (mqttClient?.connectionStatus?.state == MqttConnectionState.connected) {
      setState(() {
        level++;
      });

      // ensure we have scanned the qr code to send the message over MQTT
      if (SharedPrefsUtil.getLastScannedBikeId() == null) {
        return;
      }

      // send a message to the workout topic to increase the difficulty
      String topic = "bike/${SharedPrefsUtil.getLastScannedBikeId()!}/workout";
      String workoutType = SharedPrefsUtil.getWorkoutType()!;
      String stopMessage =
          "{\"command\": \"increase\", \"type\":\"$workoutType\"}";
      final builder = MqttClientPayloadBuilder().addString(stopMessage);
      mqttClient?.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    }
  }
}

/* MQTT Lifecycle methods for debugging */

// connection succeeded
void onConnected() {
  debugPrint('Connected');
}

// unconnected
void onDisconnected() {
  debugPrint('Disconnected');
}

// subscribe to topic succeeded
void onSubscribed(String topic) {
  debugPrint('Subscribed topic: $topic');
}

// subscribe to topic failed
void onSubscribeFail(String topic) {
  debugPrint('Failed to subscribe to topic: $topic');
}

// unsubscribe succeeded
void onUnsubscribed(String? topic) {
  debugPrint('Unsubscribed topic: $topic');
}
