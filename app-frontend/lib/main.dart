import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:redback_mobile_app/Registration/welcome_page.dart';
import 'package:redback_mobile_app/Utils/shared_prefs_util.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

Future<void> main() async {
  // access shared prefs before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // initialize shared prefs
  await SharedPrefsUtil.init();
  await Firebase.initializeApp();

  // initialize dotenv
  // await dotenv.load(fileName: ".env");

  runApp(
    MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(56, 14, 74, 1),
          primarySwatch: null),
      home: const WelcomePage(title: 'Redback Operations'),
    ),
  );
}
