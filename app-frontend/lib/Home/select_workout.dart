import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:redback_mobile_app/Utils/shared_prefs_util.dart';
import 'package:redback_mobile_app/Settings/account.dart';
import 'package:redback_mobile_app/Settings/info_page.dart';
import 'package:redback_mobile_app/Settings/settings.dart';
import 'package:redback_mobile_app/Workout/onboarding_screen.dart';
import 'package:redback_mobile_app/Home/friends_page.dart';
import 'package:redback_mobile_app/Home/arena_page.dart';
import 'package:redback_mobile_app/Profile page and fitness history page/profile_page.dart';

//This is a mockup list data for demonstration purpose only.
//Please use back-end code like node js to call the actual one from RedBack operation database.
List listData = [
  {"title": 'Ramped Workout', "code": "ramped"},
  {"title": 'Endurance Training', "code": "endurance"},
  {"title": 'Strength Training', "code": "strength"},
  {"title": 'Anaerobic Training', "code": "threshold"},
];

class SelectWorkout extends StatefulWidget {
  const SelectWorkout({super.key});

  @override
  State<StatefulWidget> createState() => SelectWorkoutState();
}

//Use flutter builder to create a list of buttons by using data from listData
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Widget _getListData(context, index) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      width: 110,
      height: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: const Color(0xFFE87461),
          padding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          SharedPrefsUtil.updateWorkoutType(listData[index]["code"]);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OnBoarding()));
        },
        child: Text(
          listData[index]["title"],
          style: const TextStyle(color: Color.fromRGBO(64, 32, 27, 1)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // List constructor
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      decoration: const BoxDecoration(
        color: Color(0x1AFFFFFF),
      ),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          // List item length
          itemCount: listData.length,
          // create list based on mockup data
          itemBuilder: _getListData), //Call HomeContent
    );
  }
}

class SelectWorkoutState extends State<SelectWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 104, 75, 182),
      appBar: AppBar(
        backgroundColor: const Color(0xFF38014A),
        elevation: 0,
        centerTitle: true,
        title: const Text('R E D B A C K'),
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
              ListTile(
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  // Here we will navigate to the accounts page
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage(index: 0),
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
                    builder: (context) => const ProfilePage(index: 2),
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
                  // Here we will navigate to the accounts page
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
              backgroundColor: Color.fromARGB(255, 230, 152, 129),
              color: Color.fromARGB(183, 255, 255, 255),
              activeColor: Color.fromARGB(255, 130, 235, 182),
              tabBackgroundColor: Color.fromARGB(55, 114, 243, 153),
              gap: 10,
              padding: EdgeInsets.all(16),
              selectedIndex: 0,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite_rounded,
                  text: 'Friends',
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendsPage(),
                      ),
                    ),
                    debugPrint("Redirecting to Friends page."),
                  },
                ),
                GButton(
                  icon: Icons.golf_course_rounded,
                  text: 'Arena',
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArenaPage(),
                      ),
                    ),
                    debugPrint("Redirecting to Arena page."),
                  },
                ),
                GButton(
                  icon: Icons.account_circle_rounded,
                  text: 'Profile',
                ),
              ]),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
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
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-0.9, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: const BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                        child: const Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Text(
                            'New Workout',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: /*Color(0xFFE87461)*/ Colors.white,
                            ),
                            textDirection: TextDirection.ltr,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 90),
                    child: HomeContent(),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-0.9, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: const BoxDecoration(
                        color: Color(0x00FFFFFF),
                      ),
                      child: const Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Text(
                          'Previous Workout',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: /*Color(0xFFE87461)*/ Colors.white,
                          ),
                          textDirection: TextDirection.ltr,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 100),
                    child: HomeContent(),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
