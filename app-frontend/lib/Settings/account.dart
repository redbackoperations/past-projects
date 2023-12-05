import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingsUi(),
    );
  }
}

class SettingsUi extends StatefulWidget {
  const SettingsUi({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsUiState();
}

class _SettingsUiState extends State<SettingsUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(102, 232, 116, 97),
        elevation: 0,
        centerTitle: true,
        title: const Text('Account'),
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
                title: const Text(
                  "Edit Profile",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
                subtitle: const Text(
                  "Name, username, etc.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white54
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Account()
                  ));
                },
                trailing: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: const Text(
                  "Privacy",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
                subtitle: const Text(
                  "Private account, disable comments, etc.",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white54
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Account()
                  ));
                },
                trailing: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: const Text(
                  "Email Address",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
                subtitle: const Text(
                  "asadasdfqwdfsaq0131@gmail.com",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white54
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Account()
                  ));
                },
                trailing: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: const Text(
                  "Terminate Account",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.red
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Account()
                  ));
                },
                trailing: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
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