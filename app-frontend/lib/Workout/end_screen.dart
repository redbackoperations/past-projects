import 'package:flutter/material.dart';
import 'package:redback_mobile_app/Home/select_workout.dart';
import 'package:redback_mobile_app/Utils/shared_prefs_util.dart';

import '../Models/workout_stats.dart';
import 'package:redback_mobile_app/Utils/size_config.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key, required this.stats});

  final WorkoutStats stats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _EndScreen(stats: stats),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    );
  }
}

class _EndScreen extends StatelessWidget {
  const _EndScreen({required this.stats});

  final WorkoutStats stats;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // Removing the app bar for the sake of design. It may be added later if needed.
      // appBar: AppBar(
      //     leading: new IconButton(
      //       icon: new Icon(Icons.arrow_back, color: Colors.black),
      //       onPressed: () => Navigator.of(context).pop(),
      //     ),
      //     backgroundColor: Color(0xFF380E4A)),
      backgroundColor: /*const Color(0xFF380E4A)*/ null,

      body: DecoratedBox(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xff380E4A),
            Color.fromARGB(255, 99, 37, 126),
            //Color.fromARGB(255, 239, 136, 120),
            Color(0xFFE87461),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Text(
                          'Well Done ${SharedPrefsUtil.instance?.getString('firstname') ?? "Example User"}!',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: /*Color(0xFFEF8B60)*/ Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Here is how your workout went',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: /*Color(0xFFEF8B60)*/ Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'Workout Length ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: /*Color.fromARGB(255, 151, 166, 185)*/
                                          Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    stats.workoutLength,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFEF8B60),
                                      fontSize: 25,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 40, 0, 0),
                                    child: Text(
                                      'Max Level ',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color:
                                            /*Color.fromARGB(255, 151, 166, 185)*/ Colors
                                                .white,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'Sustained ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: /*Color.fromARGB(255, 151, 166, 185)*/
                                          Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    'Level ${stats.maxLevel}',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFEF8B60),
                                      fontSize: 25,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 40, 0, 0),
                                    child: Text(
                                      'Max Heart',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color:
                                            /*Color.fromARGB(255, 151, 166, 185)*/ Colors
                                                .white,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'Rate ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: /*Color.fromARGB(255, 151, 166, 185)*/
                                          Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    '${stats.maxHeartRate} BPM',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFEF8B60),
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'Max Speed ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: /*Color.fromARGB(255, 151, 166, 185)*/
                                          Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    '${stats.maxSpeed.toStringAsFixed(1)} KM/H',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFEF8B60),
                                      fontSize: 25,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 40, 0, 0),
                                    child: Text(
                                      'Max Cadence ',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color:
                                            /*Color.fromARGB(255, 151, 166, 185)*/ Colors
                                                .white,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    ' ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 151, 166, 185),
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    '${stats.maxCadence.toStringAsFixed(1)} RPM',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFEF8B60),
                                      fontSize: 25,
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 40, 0, 0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Max Power',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: /*Color.fromARGB(255, 151, 166, 185)*/
                                                    Colors.white,
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              'Output ',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: /*Color.fromARGB(255, 151, 166, 185)*/
                                                    Colors.white,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ])),
                                  Text(
                                    '${stats.maxPower} W',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFEF8B60),
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ]),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // It will take us back to homepage.dart
                      debugPrint('Pressed');
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectWorkout()));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFEF8B60),
                      fixedSize: Size(SizeConfig.blockSizeHorizontal! * 50,
                          SizeConfig.blockSizeVertical! * 7),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Home'),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
