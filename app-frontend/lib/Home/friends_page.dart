import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:redback_mobile_app/Home/select_workout.dart';
import 'package:redback_mobile_app/Home/arena_page.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<StatefulWidget> createState() => _FriendsPageState();
  
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              selectedIndex: 1,
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xE8746166),
                Color(0xE8746166),
                Color(0xFF380E4A)
              ]
          )
        ),
        child: Column(
          children: [
            const SizedBox(height: 66,),
            Row(
              children: [
                Expanded(child: Container(
                  width: double.infinity,
                  height: 52,
                  margin: const EdgeInsets.only(left: 20),
                  child: const Card(
                    color: Color.fromRGBO(196, 196, 196, 0.55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                    clipBehavior: Clip.antiAlias,
                    child:  TextField(
                        decoration: InputDecoration(
                            hintText: "Find Friends",
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.search, color: Colors.white,),
                            contentPadding: EdgeInsets.only(top: 4, left: 10),
                            border: InputBorder.none)
                    ),

                  ),
                )),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Image.asset("assets/images/friendsAdd.png", width: 22, height: 16,),)
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 140,
                  height: 48,
                  margin: const EdgeInsets.only(left: 20),
                  // child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.people_sharp), label: Text("abc")),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(196, 196, 196, 1)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18.0)),)
                      )
                    ),
                      onPressed: (){},
                      child: Row(
                        children: [
                          Padding(padding: const EdgeInsets.only(right: 8), child: Image.asset("assets/images/friendsAdd.png", width: 22, height: 16,),),
                          const Text("Invite friends", style: TextStyle(fontSize: 12, color: Colors.black),)
                        ],
                      )
                  ),
                ),
                Container(
                  width: 140,
                  height: 48,
                  margin: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(196, 196, 196, 1)),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(18.0)),)
                          )
                      ),
                      onPressed: (){},
                      child: Row(
                        children: [
                          Padding(padding: const EdgeInsets.only(right: 8), child: Image.asset("assets/images/data.png", width: 24, height: 24,),),
                          const Text("This week", style: TextStyle(fontSize: 12, color: Colors.black),)
                        ],
                      )
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 402,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                  color: const Color.fromRGBO(196, 196, 196, 0.13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/user.png", width: 38, height: 38,),
                          const SizedBox(width: 5,),
                          const Text("Maggie Rangana", style: TextStyle(fontSize: 16, color: Colors.white),),
                        ],
                      ),
                      const SizedBox(height: 22,),
                      Image.asset("assets/images/bgimg1.png", width: double.infinity, height: 392/2, fit: BoxFit.fill,),
                      const SizedBox(height: 16,),
                      Row(
                        children: [
                          Image.asset("assets/images/hot.png", width: 24, height: 24, fit: BoxFit.fill,),
                          const SizedBox(width: 4,),
                          Image.asset("assets/images/like.png", width: 24, height: 24, fit: BoxFit.fill,),
                          const SizedBox(width: 4,),
                          Image.asset("assets/images/face.png", width: 24, height: 24, fit: BoxFit.fill,),
                          const SizedBox(width: 4,),
                          Image.asset("assets/images/share.png", width: 24, height: 24, fit: BoxFit.fill,),
                          const SizedBox(width: 4,),
                          Image.asset("assets/images/comments.png", width: 24, height: 24, fit: BoxFit.fill,),

                        ],
                      ),
                      const SizedBox(height: 24,),
                      Container(
                        width: double.infinity,
                        height: 48,
                        margin: const EdgeInsets.only(left: 20),
                        child: const Card(
                          color: Color.fromRGBO(196, 196, 196, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                          clipBehavior: Clip.antiAlias,
                          child:  Padding(padding: EdgeInsets.only(bottom: 20, left: 10), child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Add comment",
                                  hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.47),),
                                  // prefixIcon: Icon(Icons.search, color: Colors.white,),
                                  contentPadding: EdgeInsets.only(top: 4, left: 10),
                                  border: InputBorder.none)
                          ),),

                        ),
                      )


                    ],
                  ),
                ),

              ],
            ),)


          ],
        ),
      ),

    );
  }

}