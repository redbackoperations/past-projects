import 'package:flutter/material.dart';

class CompFeatureOnePage extends StatefulWidget {
  const CompFeatureOnePage({super.key});

  @override
  State<StatefulWidget> createState() => _CompFeatureOnePageState();
}

class _CompFeatureOnePageState extends State<CompFeatureOnePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(55, 14, 74, 0.95),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            padding: const EdgeInsets.only(bottom: 43),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'WORKOUT OPTIONS',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  fontFamily: 'Bungee'),
            ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromRGBO(232, 116, 97, 0.35),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'CENERAL OPTIONS',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      fontFamily: 'Bungee'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color.fromRGBO(233, 98, 76, 1),
                  ),
                  child: const Text(
                    'Workout Type - Distance(KM)',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color.fromRGBO(233, 98, 76, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      const Text(
                        'Kilometres(30)',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color.fromRGBO(233, 98, 76, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      const Text(
                        'Current Level(5)',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'COMPETITION',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      fontFamily: 'Bungee'),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color.fromRGBO(233, 98, 76, 1),
                      ),
                      child: const Text(
                        'Your Ghost(PB)',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color.fromRGBO(233, 98, 76, 1),
                      ),
                      child: const Text(
                        'Play with Friend',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                      ),
                      child: const Text(
                        'Friend\'s Ghost',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color.fromRGBO(233, 98, 76, 1),
                      ),
                      child: const Text(
                        'Leaderboards',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'PLAYING AGAINST JIMMY\'S GHOST',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      fontFamily: 'Bungee'),
                ),
              ],
            ),
          )),
          Container(
            width: double.infinity,
            height: 74,
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: const [
                    Text("START"),
                    Text("Workout"),
                  ],
                ),
              ),
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
