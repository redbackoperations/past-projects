import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:redback_mobile_app/Home/select_workout.dart';
import 'package:redback_mobile_app/Home/friends_page.dart';

class ArenaPage extends StatelessWidget {
  const ArenaPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Arena2Page(),
    );
  }
}

class Arena2Page extends StatefulWidget {
  const Arena2Page({Key? key}) : super(key: key);

  @override
  State<Arena2Page> createState() => _Arena2Page();
}

class _Arena2Page extends State<Arena2Page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(181, 79, 92, 1),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(78, 34, 84, 1),
        foregroundColor: Colors.white,
        title: const Text(
          "The Arena",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 27,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(51, 19, 71, 0),
              Color.fromRGBO(51, 19, 71, 0.25),
              Color.fromRGBO(51, 19, 71, 0.5),
              Color.fromRGBO(51, 19, 71, 0.75),
              Color.fromRGBO(51, 19, 71, 1),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.only(
            bottom: 50,
          ),
          children: [
            Container(
              width: double.infinity,
              height: 180,
              color: const Color.fromRGBO(181, 79, 92, 1),
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "    Start a public challenge",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right:10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 150,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          color: Colors.white,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          color: const Color.fromRGBO(239, 93, 62, 1),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: const [
                                              Text(
                                                "CBD Walk",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                "12,345 Started",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                        "https://www.deutsche-apotheker-zeitung.de/_Resources/Persistent/3/4/8/1/3481a4996ddc3b74fe03ad147c1b2e182312d21c/A292022_S6_WM_Maskottchen2022_3545346-567x700.jpg"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Join a public challenge",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 3,
                right: 10,
                left: 10,
              ),
              margin: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 106, 84, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://www.deutsche-apotheker-zeitung.de/_Resources/Persistent/3/4/8/1/3481a4996ddc3b74fe03ad147c1b2e182312d21c/A292022_S6_WM_Maskottchen2022_3545346-567x700.jpg",
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const SizedBox(
                    width: 100,
                    child:  Text(
                      "#ChallengeName",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.2),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Text(
                            "12,345: Joined",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.2),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Text(
                            "Completed: Yesterday",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const Text(
                    "Challenge history",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "View All  ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 3,
                right: 10,
                left: 10,
              ),
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 106, 84, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://www.deutsche-apotheker-zeitung.de/_Resources/Persistent/3/4/8/1/3481a4996ddc3b74fe03ad147c1b2e182312d21c/A292022_S6_WM_Maskottchen2022_3545346-567x700.jpg",
                      ),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "1-Day Friendly Challenge",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          const Text(
                            "User challenged you!",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Ended. 2 years ago",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Live Events",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 3,
                right: 10,
                left: 10,
              ),
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 106, 84, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://www.deutsche-apotheker-zeitung.de/_Resources/Persistent/3/4/8/1/3481a4996ddc3b74fe03ad147c1b2e182312d21c/A292022_S6_WM_Maskottchen2022_3545346-567x700.jpg",
                      ),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "1-Day Friendly Challenge",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          const Text(
                            "User challenged you!",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Started. 2 days ago",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 230, 152, 129),
        child:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
              backgroundColor: Color.fromARGB(255, 230, 152, 129),
              color: Color.fromARGB(183, 255, 255, 255),
              activeColor: Color.fromARGB(255, 130, 235, 182),
              tabBackgroundColor: Color.fromARGB(55, 114, 243, 153),
              gap: 10,
              padding: EdgeInsets.all(16),
              selectedIndex: 2,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  onPressed: ()  => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectWorkout(),
                      ),
                    ),
                    debugPrint("Redirecting to Home page(select_workout page)."),
                  },
                ),
                GButton(
                  icon: Icons.favorite_rounded,
                  text: 'Friends',
                  onPressed: ()  => {
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
                  onPressed: ()  => {
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
    );
  }
}


