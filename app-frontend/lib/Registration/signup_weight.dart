import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:redback_mobile_app/Models/user_info.dart';
import 'package:redback_mobile_app/Utils/constants.dart' as constants;
import 'package:wheel_slider/wheel_slider.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key, required this.userInfo}) : super(key: key);
  final UserInfo userInfo;

  @override
  State<StatefulWidget> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int initWeight = 0;
  int totalWeight = 400;
  int weight = 0;
  String units = "kg";
  Color kgColor = const Color(0xFFE87461);
  Color lbsColor = const Color.fromARGB(255, 255, 255, 255);
  UserInfo userInfo = UserInfo("firstName", "secondName", "email", "password",
      "userName", "mobile", "gender", "height", "weight");

  @override
  void initState() {
    super.initState();
    userInfo = widget.userInfo;
  }

  void _buttonKg() {
    setState(() {
      units = "kg";
      kgColor = const Color(0xFFE87461);
      lbsColor = const Color.fromARGB(255, 255, 255, 255);
    });
  }

  void _buttonLbs() {
    setState(() {
      units = "lbs";
      kgColor = const Color.fromARGB(255, 255, 255, 255);
      lbsColor = const Color(0xFFE87461);
    });
  }

  void _updateLabels(int val) {
    setState(() {
      weight = val;
    });
  }

  //This function makes a post request to the server and signup endpoint and passes a
  //body of values taken from the signup form
  Future<bool> postData(UserInfo user) async {
    //creating a http client that can use the different api requests
    var client = http.Client();
    try {
      // use 127.0.0.1 when testing with a browser and 10.0.2.2 when testing with the emulator
      String uri = '${constants.server}/signup';
      var response = await client.post(Uri.parse(uri),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: jsonEncode({
            "username": user.userName,
            "firstname": user.firstName,
            "lastname": user.secondName,
            "email": user.email,
            "password": user.password,
            "redbackCoins": 0,
            "telephone": int.parse(user.mobile),
            "userLevel": 0,
            "followers": "",
            "following": "",
            "img": "",
            "gender": user.gender,
            "height": int.parse(user.height),
            "weight": user.weight
          }));
      client.close();
      // if response = 200 (OK), signup is successful, return true
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    // signup is not successful, return false
    return false;
  }

  // go to next screen
  Future<bool> signup() async {
    // set weight
    userInfo.weight = weight.toString() + units;
    final dataSend = await postData(userInfo);
    if (dataSend) {
      Fluttertoast.showToast(
          msg: "Signup successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "Signup failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    /*
    print(userInfo.firstName);
    print(userInfo.secondName);
    print(userInfo.email);
    print(userInfo.password);
    print(userInfo.userName);
    print(userInfo.mobile);
    print(userInfo.gender);
    print(userInfo.height);
    print(userInfo.weight);
    */
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
                  Color(0xff380E4A),
                  Color(0xFFE87461),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: kToolbarHeight,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              //passing this to our root
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: const LinearProgressIndicator(
                              value: 1,
                              valueColor:
                                  AlwaysStoppedAnimation(Color(0xFFE87461)),
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
                      'What is your weight?',
                      style: TextStyle(
                        color: Color(0xFFE87461),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 60,
                          //kg button
                          child: ElevatedButton(
                            onPressed: () {
                              _buttonKg();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(kgColor),
                            ),
                            child: Text("kg",
                                style:
                                    TextStyle(fontSize: 25, color: lbsColor)),
                          ),
                        ),
                        const SizedBox(width: 40),
                        //lbs button
                        SizedBox(
                          width: 100,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _buttonLbs();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(lbsColor),
                            ),
                            child: Text("lbs",
                                style: TextStyle(fontSize: 25, color: kgColor)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    // show current selected weight
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                        child: Text(
                          '$weight',
                          style: const TextStyle(
                            color: Color(0xFFE87461),
                            fontSize: 60,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 115, 0, 10),
                        child: Text(
                          units,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 48, 47, 47),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // wheel slider
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                    // can be changed to WheelSlider and WheelSlider.number
                    // WheelSlider has only lines whereas WheelSlider.number shows only the numbers
                    child: WheelSlider.number(
                        perspective: 0.01,
                        // perspective only included in WheelSlider.number
                        currentIndex: 0,
                        totalCount: totalWeight,
                        initValue: initWeight,
                        isVibrate: false,
                        onValueChanged: (val) {
                          _updateLabels(val);
                        }),
                  ),

                  SizedBox(
                    width: 280,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (await signup()) {
                          // if signup successful, navigate back to menu screen (first screen)
                          if (!mounted) return;
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        }
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
                        'Signup',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
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
    );
  }
}
