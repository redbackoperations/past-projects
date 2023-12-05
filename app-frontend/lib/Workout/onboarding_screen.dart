import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redback_mobile_app/Utils/constants.dart' as constants;
import 'package:redback_mobile_app/Utils/shared_prefs_util.dart';
import 'package:redback_mobile_app/Workout/mid_workout.dart';
import 'package:redback_mobile_app/Workout/start_comp_feat1.dart';
import 'package:redback_mobile_app/Workout/scan.dart';
import 'package:redback_mobile_app/Utils/size_config.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingState();
  }
}

class OnboardingState extends StatefulWidget {
  const OnboardingState({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingState> {
  String? lastScannedCode = SharedPrefsUtil.getLastScannedBikeId();
  String workoutType = SharedPrefsUtil.getWorkoutType()!;

  bool qrMissingWarningShown = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        // icon back button
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        // App Bar Background color
        backgroundColor: const Color(0xFF380E4A),
        actions: <Widget>[
          Align(
            alignment: Alignment.topRight,
            // Icon button with the QR Icon for the QR Scanner
            child: Padding(
              // Padding to ensure that icon button is not on the edge of the screen
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal! * 10),
              // Adding a file background to make the icon stand out
              child: Ink(
                decoration: const ShapeDecoration(
                    color: Color(0xFFEF8B60), shape: CircleBorder()),
                child: IconButton(
                  icon: const Icon(Icons.qr_code_2),
                  tooltip: "QR Code Scanner",
                  iconSize: 35,
                  color: Colors.black,
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ScanQrPage()));
                    _reSyncPreviousCodeString();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      // DecoratedBox allows us to create the gradient background
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
          ),
        ),

        // Column child that will house the onboarding paragraphs
        child: SafeArea(
          child: SizedBox(
            height: SizeConfig.blockSizeVertical! * 100,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 4,
                  ),
                  // Text box tile
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal! * 10),
                    child: Text(
                      constants.workoutNames[workoutType]!,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: /*Color(0xFFEF8B60)*/ Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 4,
                  ),
                  // Text box paragraph
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal! * 10),
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 80,
                      child: Text(constants.onboardingTexts[workoutType]!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: /*Color(0xFFEF8B60)*/ Colors.white,
                          )),
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 4,
                  ),
                  // Last qr code message box 1
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal! * 10,
                      ),
                      child: Text(
                          lastScannedCode != null
                              ? "Last Bike Code Scanned"
                              : "Bike Code Required",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: /*Color(0xFFEF8B60)*/ Colors.white,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 4,
                  ),
                  // Last qr code message box 2

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal! * 10,
                    ),
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 80,
                      child: Text(
                          lastScannedCode != null
                              ? "ID: ${lastScannedCode!}\nNot your current bike? Scan the QR Code on the current bike you are using before you begin"
                              : "Please scan the QR code on the bike before commencing the workout",
                          style: const TextStyle(
                            fontSize: 16,
                            color: /*Color(0xFFEF8B60)*/ Colors.white,
                          )),
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 4,
                  ),
                  // Start button for user to start workout
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal! * 10,
                      //vertical: SizeConfig.blockSizeVertical! * 2,
                    ),
                    child: ElevatedButton(
                      // allow dev access in debug but the workout wont work if no code is scanned at least once so its saved in shared prefs
                      // in other run modes, require the user to scan the code before proceeding
                      onPressed: lastScannedCode != null || kDebugMode
                          ? handleStartPress
                          : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFEF8B60),
                        fixedSize: const Size(180, 40),
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Start'),
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _reSyncPreviousCodeString() {
    setState(() {
      lastScannedCode = SharedPrefsUtil.getLastScannedBikeId();
    });
  }

  handleStartPress() {
    // show a toast informing the user that it is advised to scan the qr code whilst in debug.
    // Users wont reach this point when running in release mode as they will be require to scan the QR code first
    // we only show this message once per run
    if (kDebugMode &&
        !qrMissingWarningShown &&
        SharedPrefsUtil.getLastScannedBikeId() == null) {
      Fluttertoast.showToast(
          msg: "Please scan the QR code",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);

      qrMissingWarningShown = true;
      return;
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MidWorkout()));
  }
}
