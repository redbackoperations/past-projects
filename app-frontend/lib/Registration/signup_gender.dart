import 'package:flutter/material.dart';
import 'package:redback_mobile_app/Models/user_info.dart';
import 'package:redback_mobile_app/Registration/signup_height.dart';

class SelectGenderPage extends StatefulWidget {
  const SelectGenderPage({Key? key, required this.userInfo}) : super(key: key);
  final UserInfo userInfo;

  @override
  State<StatefulWidget> createState() => _SelectGenderPage();
}

class _SelectGenderPage extends State<SelectGenderPage> {
  Color buttonMaleColor = Colors.deepPurpleAccent;
  Color buttonFemaleColor = const Color.fromARGB(100, 255, 109, 64);
  String gender = "";
  UserInfo userInfo = UserInfo("firstName", "secondName", "email", "password",
      "userName", "mobile", "gender", "height", "weight");

  @override
  void initState() {
    super.initState();
    userInfo = widget.userInfo;
  }

// male button is pressed
  void _buttonMale() {
    debugPrint("pressed male");
    setState(() {
      gender = "male";
      buttonFemaleColor = const Color.fromARGB(100, 255, 109, 64);
      buttonMaleColor = Colors.deepPurpleAccent;
    });
  }

// female button is pressed
  void _buttonFemale() {
    debugPrint("pressed female");
    setState(() {
      gender = "female";
      buttonFemaleColor = const Color(0xFFE87461);
      buttonMaleColor = const Color.fromARGB(100, 124, 77, 255);
    });
  }

// prefer not to choose button is pressed
  void _buttonUnspecified() {
    debugPrint("pressed unspecified");
    userInfo.gender = "unspecified";
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HeightPage(
                  userInfo: userInfo,
                  title: '',
                )));
  }

// next button is pressed
  void _buttonNext() {
    userInfo.gender = gender;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HeightPage(
                  userInfo: userInfo,
                  title: '',
                )));
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
                              value: 0.33,
                              valueColor:
                                  AlwaysStoppedAnimation(Color(0xFFE87461)),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: const Alignment(0.0, -0.6),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'What is your biological sex?',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xFFE87461),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 64),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 145,
                                  height: 180,
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _buttonMale();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        buttonMaleColor,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.male,
                                            color: Colors.deepPurple, size: 32),
                                        SizedBox(width: 145, height: 12),
                                        Text(
                                          'Male',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Container(
                                  width: 145,
                                  height: 180,
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _buttonFemale();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        buttonFemaleColor,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.female,
                                            color: Colors.white, size: 32),
                                        SizedBox(width: 145, height: 12),
                                        Text(
                                          'Female',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 48),
                            const SizedBox(
                              width: 300,
                              child: Text(
                                'Calculating energy expenditure during the workout will require knowledge of your biological sex. If you do not feel conformable disclosing this information, you can skip this information by selecting \'Prefer not to choose\'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 64),
// next button
                            SizedBox(
                              width: 280,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  _buttonNext();
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
// prefer not to choose button (gender = "unspecified")
                            const SizedBox(height: 32),
                            TextButton(
                              onPressed: () {
                                _buttonUnspecified();
                              },
                              child: const Text(
                                'Prefer not to choose',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
