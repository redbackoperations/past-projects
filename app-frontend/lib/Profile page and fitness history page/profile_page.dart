import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:redback_mobile_app/Home/select_workout.dart';
import 'package:redback_mobile_app/Home/friends_page.dart';
import 'package:redback_mobile_app/Home/arena_page.dart';

class ProfilePage extends StatelessWidget {
  final int index;
  const ProfilePage({Key? key, required this.index}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Profile3Page(index: index),
    );
  }
}

class Profile3Page extends StatefulWidget {
  final int index;
  const Profile3Page({Key? key, required this.index}) : super(key: key);

  @override
  State<Profile3Page> createState() => _Profile3PageState();
}

class _Profile3PageState extends State<Profile3Page>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.index,
    );
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
      body: SafeArea(
        child: Container(
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
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  color: const Color.fromRGBO(217, 106, 84, 1),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    indicatorColor: Color.fromRGBO(234, 52, 95, 1),
                    indicatorWeight: 4,
                    tabs: [
                      Tab(
                        text: "PROFILE",
                      ),
                      Tab(
                        text: "HOME",
                      ),
                      Tab(
                        text: "ACTIVITIVES",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// PROFILE
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Profile",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.settings,
                                      color: Color.fromRGBO(219, 219, 219, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Redback Team",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(192, 167, 177, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        ...List.generate(
                                          4,
                                          (index) => buildHead(index),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Image.asset(
                                "assets/images/BLogo.png",
                                width: 108,
                                height: 108,
                              ),
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 500,
                              child: LineChartSample(),
                            ),
                          ],
                        ),
                      ),

                      /// HOME
                      Container(
                        height: 150,
                      ),

                      /// ACTIVITIVES
                      ListView(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Text(
                                  "Daily",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(217, 106, 84, 1),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Text(
                                  "Weekly",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Text(
                                  "Monthlv",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 240,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    padding: const EdgeInsets.only(
                                      bottom: 60,
                                      right: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: const [
                                        Text(
                                          "160",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "120",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "80",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "40",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "0",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 190,
                                        alignment: Alignment.bottomCenter,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 15,
                                          height: 90,
                                          alignment: Alignment.bottomCenter,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                110, 210, 229, 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Sun",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 190,
                                        alignment: Alignment.bottomCenter,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 15,
                                          height: 60,
                                          alignment: Alignment.bottomCenter,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                110, 210, 229, 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Mon",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 190,
                                        alignment: Alignment.bottomCenter,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 15,
                                          height: 30,
                                          alignment: Alignment.bottomCenter,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                110, 210, 229, 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Tue",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 190,
                                        alignment: Alignment.bottomCenter,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 15,
                                          height: 110,
                                          alignment: Alignment.bottomCenter,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                110, 210, 229, 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Wed",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 190,
                                        alignment: Alignment.bottomCenter,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 15,
                                          height: 150,
                                          alignment: Alignment.bottomCenter,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                110, 210, 229, 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Thu",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 190,
                                        alignment: Alignment.bottomCenter,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 15,
                                          height: 160,
                                          alignment: Alignment.bottomCenter,
                                          decoration: const BoxDecoration(
                                            color:
                                                Color.fromRGBO(220, 77, 78, 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Thu",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 190,
                                        alignment: Alignment.bottomCenter,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 15,
                                          height: 110,
                                          alignment: Alignment.bottomCenter,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                110, 210, 229, 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Fri",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 190,
                                        alignment: Alignment.bottomCenter,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 15,
                                          height: 80,
                                          alignment: Alignment.bottomCenter,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                110, 210, 229, 1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Sat",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(194, 54, 125, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Total steps",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          "3500    ",
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "(Kcal)",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const PieChartSample(),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Text(
                                        "28%",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 220,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          138, 128, 160, 1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(60),
                                          ),
                                          child: const Icon(
                                            Icons.local_fire_department,
                                            size: 40,
                                            color: Color.fromRGBO(
                                                218, 122, 103, 1),
                                          ),
                                        ),
                                        const Text(
                                          "Calories burnt",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                        ),
                                        const Text(
                                          "512",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                        ),
                                        const Text(
                                          "Kcal",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 220,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(156, 66, 127, 1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(60),
                                          ),
                                          child: const Icon(
                                            Icons.local_fire_department,
                                            size: 40,
                                            color: Color.fromRGBO(
                                                218, 122, 103, 1),
                                          ),
                                        ),
                                        const Text(
                                          "Calories left",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                        ),
                                        const Text(
                                          "1705",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                        ),
                                        const Text(
                                          "Kcal",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectWorkout(),
                      ),
                    ),
                    debugPrint(
                        "Redirecting to Home page(select_workout page)."),
                  },
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
              ]),
        ),
      ),
    );
  }

  buildHead(int i) {
    return Positioned(
      right: 30.0 * i,
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
            "https://img0.baidu.com/it/u=2678900795,2246882042&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=496",
          ),
        ),
      ),
    );
  }
}

class LineChartSample extends StatefulWidget {
  const LineChartSample({super.key});

  @override
  State<LineChartSample> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample> {
  List<Color> gradientColors = [
    const Color.fromRGBO(55, 21, 84, 1),
    const Color.fromRGBO(215, 74, 194, 1),
    const Color.fromRGBO(215, 74, 194, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 500,
            child: AspectRatio(
              aspectRatio: 3,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 18,
                    left: 12,
                    top: 24,
                    bottom: 30,
                  ),
                  child: LineChart(
                    mainData(),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            child: Container(
              width: 5,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            child: Container(
              width: 2000,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Jan', style: style);
        break;
      case 3:
        text = const Text('Feb', style: style);
        break;
      case 5:
        text = const Text('Mar', style: style);
        break;
      case 7:
        text = const Text('Apr', style: style);
        break;
      case 9:
        text = const Text('May', style: style);
        break;
      case 11:
        text = const Text('Jun', style: style);
        break;
      case 13:
        text = const Text('Jul', style: style);
        break;
      case 15:
        text = const Text('Aug', style: style);
        break;
      case 17:
        text = const Text('Set', style: style);
        break;
      case 19:
        text = const Text('Oct', style: style);
        break;
      case 21:
        text = const Text('Nov', style: style);
        break;
      case 23:
        text = const Text('Dec', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: topTitleWidgets,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 26,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 0.2),
            FlSpot(2, 4.2),
            FlSpot(5, 2.2),
            FlSpot(8, 5.2),
            FlSpot(11, 1.2),
            FlSpot(15, 5.6),
            FlSpot(19, 3),
            FlSpot(23, 1.9),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class PieChartSample extends StatefulWidget {
  const PieChartSample({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 20,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      const radius = 20.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color.fromRGBO(110, 210, 229, 1),
            value: 25,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color.fromRGBO(110, 210, 229, 1),
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color.fromRGBO(194, 54, 125, 1),
            value: 20,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 4:
          return PieChartSectionData(
            color: const Color.fromRGBO(110, 210, 229, 1),
            value: 25,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
