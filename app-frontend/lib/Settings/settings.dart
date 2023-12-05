import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:redback_mobile_app/Settings/account.dart';
import 'package:redback_mobile_app/Settings/info_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(102, 232, 116, 97),
        elevation: 0,
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(102, 232, 116, 97),
              Color.fromARGB(255, 56, 14, 74),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.account_box,
                  color: Colors.white,
                ),
                title: const Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Account()
                  ));
                },
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: const Text(
                  "Information",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InformationPage()
                  ));
                },
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.help,
                  color: Colors.white,
                ),
                title: const Text(
                  "Help",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FAQPage()
                  ));
                },
              )
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