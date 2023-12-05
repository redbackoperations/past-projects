// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:redback_mobile_app/Utils/constants.dart' as constants;
import 'package:redback_mobile_app/Utils/shared_prefs_util.dart';
import 'package:redback_mobile_app/Settings/account.dart';
import 'package:redback_mobile_app/Settings/info_page.dart';
import 'package:redback_mobile_app/Settings/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late String username, firstname, lastname;

  // refresh the authentication tokens - runs on initialization
  refreshToken() async {
    var client = http.Client();
    // use 127.0.0.1 when testing with a browser and 10.0.2.2 when testing with the emulator
    var response =
    await client.post(Uri.parse("${constants.server}/refreshToken"),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            body: jsonEncode({
              "token": SharedPrefsUtil.getRequiredValue("refreshToken"),
            }));
    if (response.statusCode == 200) {
      var values = json.decode(response.body);
      SharedPrefsUtil.setTokens(values);
    }
  }

  // Obtain and saves up-to-date user details (must be logged in with valid credentials) - runs on initialization
  getUser(bool loop) async {
    try {
      var client = http.Client();
      var username = SharedPrefsUtil.getRequiredValue('username');
      var accessToken = SharedPrefsUtil.getRequiredValue('accessToken');
      // Obtain and save user details
      // use 127.0.0.1 when testing with a browser and 10.0.2.2 when testing with the emulator
      var response = await client.get(
        Uri.parse('${constants.server}/user/$username'),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer $accessToken"
        },
      );
      if (response.statusCode == 200) {
        // update all values
        var userValues = jsonDecode(response.body);
        SharedPrefsUtil.setUserDetails(userValues);
        client.close();
      } else if (loop) {
        // if failed because of token, refresh token first then repeat
        await refreshToken();
        await getUser(false);
      } else {
        print("Error: Invalid refresh token. Require re-login");
      }
    } catch (e) {
      print(e);
    }
  }

  // get username for Future<String> instances - ensures that username data is populated before loading text in widget
  Future<String> getUsername() async {
    return SharedPrefsUtil.getRequiredValue("username");
  }

  // get full name for Future<String> instances - ensures that name data is populated before loading text in widget
  Future<String> getFullName() async {
    firstname = SharedPrefsUtil.getRequiredValue("firstname");
    lastname = SharedPrefsUtil.getRequiredValue("lastname");
    return "$firstname $lastname";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundCloor: Color.fromARGB(255, 104, 75, 182),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 104, 75, 182),
        elevation: 0,
        centerTitle: true,
        title: const Text('R E D B A C K'),
      ),
      body: Center(
        // show Future<String> text for username, only shows when username data has been obtained
        child: FutureBuilder<String>(
            future: getFullName(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Text('Welcome ${snapshot.data}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 230, 152, 129),
                      ));
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 230, 152, 129),
          child: ListView(
            children: [
              const DrawerHeader(
                  child: Center(
                    child: Text(
                      'REDBACK',
                      style: TextStyle(fontSize: 30),
                    ),
                  )),
              // "welcome [user]" in hamburger menu
              ListTile(
                title: FutureBuilder<String>(
                    future: getUsername(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return Text(
                            'Welcome $username',
                            style: const TextStyle(fontSize: 20),
                          );
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    }),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  // Here we will navigate to the profile page
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Account(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.history_edu_rounded),
                title: const Text(
                  'Fitness History',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  // Here we will navigate to the information page
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const InformationPage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  // Here we will navigate to the settings page
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.report_gmailerrorred),
                title: const Text(
                  'Report an Issue',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  // Here we will navigate to the issue page
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ContactPage(),
                  ));
                },
              ),
            ],
          ),
        ),
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
}
