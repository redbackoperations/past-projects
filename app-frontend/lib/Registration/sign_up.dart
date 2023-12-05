// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:redback_mobile_app/Models/user_info.dart';
import 'package:redback_mobile_app/Registration/log_in.dart';
import 'package:redback_mobile_app/Registration/signup_gender.dart';
import 'package:redback_mobile_app/Utils/constants.dart' as constants;
import 'package:redback_mobile_app/Utils/size_config.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // our form key
  final _formKey = GlobalKey<FormState>();

  //here we declare the field variables that will be used in the signup
  late var firstNameField;
  late var secondNameField;
  late var emailField;
  late var passwordField;
  late var userNameField;
  late var mobileField;
  late var emptyFollowers = '';
  late var emptyFollowing = '';
  late var emptyImg = '';

  //below are our text editing controllers for each field
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final userNameEditingController = TextEditingController();
  final mobileNumberEditingController = TextEditingController();

  // // declare UserInfo object to be passed to next screens
  // UserInfo userInfo = UserInfo("firstName", "secondName", "email", "password",
  //     "userName", "mobile", "gender", "height", "weight");

  void toastShow(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // check inputs and send data to next page
  // need to check/remove for trailing spaces
  // need to check password min length
  Future<bool> validateData() async {
    try {
      var client = http.Client();
      // check for any empty fields
      if (firstNameEditingController.text == "" ||
          secondNameEditingController.text == "" ||
          emailEditingController.text == "" ||
          passwordEditingController.text == "" ||
          userNameEditingController.text == "" ||
          mobileNumberEditingController.text == "") {
        // if any empty fields, show toast with msg to fill all fields
        toastShow("Please fill in all required fields");
        // else - no empty fields
        // check for matching confirm password
      } else if (passwordEditingController.text !=
          confirmPasswordEditingController.text) {
        // if password does not match, show toast
        toastShow("Password does not match");
        // else - password matches
        // check username max length
      } else if (userNameEditingController.text.length >= 24) {
        toastShow("Username must be less than 24 characters");
        // else - username is less than max length
        // check for existing users with username
      } else {
        var responseUserName = await client.get(
            Uri.parse(
                '${constants.server}/checkusername/${userNameEditingController.text}'),
            headers: {"Content-Type": "application/json; charset=utf-8"});
        print("username taken: ${responseUserName.body}");
        // if username is taken
        if (responseUserName.body != 'false') {
          // show toast username taken
          toastShow("Username taken");
          // else - username not taken
        } else {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(emailEditingController.text);
          print("emailValid: $emailValid");
          //check for valid email
          if (!emailValid) {
            // show toast invalid email
            toastShow("Invalid email");
            // else - email valid
          } else {
            // check for existing users with email
            var responseEmail = await client.get(
                Uri.parse(
                    '${constants.server}/checkemail/${emailEditingController.text}'),
                headers: {"Content-Type": "application/json; charset=utf-8"});
            print("email taken: ${responseEmail.body}");
            // if email is not taken
            if (responseEmail.body != 'false') {
              // show toast email already in use
              toastShow("Email already in use");
              // else - email is not taken
            } else {
              // return true - validation passed
              return true;
            }
          }
        }
      }
    } catch (e) {
      print(e);
      print("error above");
    }
    return false;
  }

  // validate data then open next page
  Future<bool> _nextPage() async {
    // if validation passed, go to next page
    return await validateData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    //username field
    userNameField = TextFormField(
        autofocus: false,
        controller: userNameEditingController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: const Color(0xffffffff),
          filled: true,
          prefixIcon: const Icon(Icons.account_circle),
          hintText: "User Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));
    firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: const Color(0xffffffff),
          filled: true,
          prefixIcon: const Icon(Icons.account_circle),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

    //last name field
    secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: const Color(0xffffffff),
          filled: true,
          prefixIcon: const Icon(Icons.account_circle),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

    //email field
    emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: const Color(0xffffffff),
          filled: true,
          prefixIcon: const Icon(Icons.mail),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

    //password field
    passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: const Color(0xffffffff),
          filled: true,
          prefixIcon: const Icon(Icons.vpn_key),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xFFe87461),
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: emailEditingController.text,
                    password: passwordEditingController.text)
                .then((value) {
              print("Created New Account");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }).catchError((error) {
              String errorMessage = "An error occurred, please try again.";
              if (error is FirebaseAuthException) {
                switch (error.code) {
                  case "email-already-in-use":
                    errorMessage = "Email is already in use.";
                    break;
                  case "invalid-email":
                    errorMessage = "Email address is invalid.";
                    break;
                  case "weak-password":
                    errorMessage = "Password is too weak.";
                    break;
                }
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.white,
                  content:
                      Text(errorMessage, style: TextStyle(color: Colors.black)),
                  duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                    label: "Dismiss",
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            });
          },
          child: const Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE87461),
              Color.fromARGB(255, 99, 37, 126),
              Color(0xff380E4A),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              /*color: const Color.fromRGBO(56, 14, 74, 1),*/
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Image.asset('assets/images/Logo.png'),
                      SizedBox(
                          height: SizeConfig.blockSizeVertical! * 22,
                          //image logo
                          child: Image.asset(
                            'assets/images/BLogo.png',
                            fit: BoxFit.contain,
                          )),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 7,
                      ),
                      userNameField,
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 1,
                      ),

                      Row(
                        children: [
                          Expanded(child: firstNameField),
                          SizedBox(
                            width: SizeConfig.blockSizeVertical! * 1,
                          ),
                          Expanded(child: secondNameField),
                        ],
                      ),

                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 1,
                      ),
                      emailField,
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 1,
                      ),
                      passwordField,
                      // const SizedBox(height: 20),
                      // confirmPasswordField,

                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 12,
                      ),
                      // mobileField,
                      // const SizedBox(height: 20),
                      signUpButton,
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Already have account? ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: /*Color(0xFFe87461)*/
                                      //Color(0xFFE87461),
                                      Color(0xFFE8364B2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
