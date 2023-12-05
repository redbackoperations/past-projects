import 'package:flutter/material.dart';
// TODO: Find null safe replacement library
import 'package:flutter_circular_slider/flutter_circular_slider.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:redback_mobile_app/Models/user_info.dart';
import 'package:redback_mobile_app/Registration/signup_weight.dart';

// flutter run --no-sound-null-safety

class HeightPage extends StatefulWidget {
  const HeightPage({Key? key, required this.userInfo, required String title})
      : super(key: key);
  final UserInfo userInfo;

  @override
  State<StatefulWidget> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  final baseColor = const Color(0xFFE87461);

  int initHeight = 0;
  int inHeight = 0;
  UserInfo userInfo = UserInfo("firstName", "secondName", "email", "password",
      "userName", "mobile", "gender", "height", "weight");

  @override
  void initState() {
    super.initState();
    _shuffle();
    userInfo = widget.userInfo;
  }

//Initialized values
  void _shuffle() {
    setState(() {
      initHeight = 0;
      inHeight = initHeight;
    });
  }

//Functions called when the button is slid
  void _updateLabels(int init, int end, int b) {
    setState(() {
      inHeight = end;
    });
  }

  // go to next screen (WeightPage)
  void nextPage() {
    // set height before sending data to next screen
    userInfo.height = inHeight.toString();
    // open weight page
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeightPage(userInfo: userInfo)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF380E4A),
                  Color(0xFFE87461),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                      child: Stack(
                        children: [
                          SafeArea(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: const LinearProgressIndicator(
                                value: 0.66,
                                valueColor: AlwaysStoppedAnimation(
                                  Color(0xFFE87461),
                                ),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 70, 0, 10),
                      child: Text(
                        'What is your height?',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFFE87461),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // height circular slider
                    SingleCircularSlider(
                      220, // max height
                      initHeight,
                      height: 400.0,
                      width: 300.0,
                      showRoundedCapInSelection: false,
                      baseColor: const Color.fromARGB(255, 46, 45, 45),
                      selectionColor: baseColor,
                      handlerColor: const Color.fromARGB(255, 0, 0, 0),
                      handlerOutterRadius: 10.0,
                      onSelectionChange: _updateLabels,
                      sliderStrokeWidth: 30.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_formatIntervalHeight(inHeight),
                                  style: const TextStyle(
                                      fontSize: 40.0, color: Colors.white)),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Text('CM',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white)),
                              ),
                            ]),
                      ),
                    ),
                    //Jump button
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 28, 8, 8),
                        child: SizedBox(
                          width: 280,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              nextPage();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: const Color(0xFF7265E3),
                              fixedSize: const Size(180, 40),
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const []),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//Output the changed height value
  String _formatIntervalHeight(int init) {
    var height = init;
    return '$height';
  }
}
