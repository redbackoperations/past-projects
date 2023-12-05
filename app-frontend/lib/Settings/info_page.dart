import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:redback_mobile_app/Utils/size_config.dart';

List pages = ["News", "About us", "Contact us", "FAQ"];

//These are mockup list data for demonstration purpose only.
//Please use back-end code to call the actual one from RedBack operation database.
List newsList = [
  {
    "news":
        'Industry Guest Lecture from Daniel Yong, Midnyte City Monday 12pm-1pm',
    "time": 15
  },
  {
    "news":
        'Leadership Conference is being held tomorrow Saturday 30th April from 2-3:30pm',
    "time": 42
  },
  {
    "news": 'Cohort Contribution: Become a Faculty of SEBE Peer Mentor.',
    "time": 60
  },
  {"news": 'Placeholder', "time": 90},
  {"news": 'Some more news', "time": 1440},
  {"news": 'Another thing', "time": 28475},
  {
    "news":
        'This is an extremely long string of text, designed to test whether or not the text will overflow and ruin the UI, so thats why this very long text exists I guess. Lorem ipsum dolor sit amet, some more placeholder text, words, birds, shmirds, that might be enough, lets check',
    "time": 525600
  },
];

List aboutUsList = [
  "about us text",
  "more about us text",
  "some extra about us text",
  "test about us text",
  "bird about us text"
];

List contactUsList = [
  "contact us text",
  "more contact us text",
  "some extra contact us text",
  "test contact us text",
  "bird contact us text"
];

List faqList = [
  "answer text",
  "more answer text",
  "some extra answer text",
  "test answer text",
  "bird answer text"
];

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  Widget getTopButtons(context, index) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
      width: 100,
      height: 20,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: index == 0
                ? const Color.fromARGB(255, 232, 116, 97)
                : const Color.fromARGB(102, 232, 116, 97),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0))),
        onPressed: () {
          index != 0 ? Navigator.of(context).pop() : null;
          index != 0
              ? (index == 1
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutUsPage()))
                  : (index == 2
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ContactPage()))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const FAQPage()))))
              : null;
        },
        child: Text(
          pages[index],
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget getData(context, index) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      width: double.infinity,
      height: 200,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 232, 116, 97),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            alignment: Alignment.centerLeft,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const InformationPage()));
          },
          child: RichText(
            text: TextSpan(
                text: "Redback News\n",
                style: const TextStyle(
                  color: Color.fromARGB(255, 7, 45, 75),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(text: "\n"),
                  TextSpan(
                    text: newsList[index]["news"].substring(
                        0,
                        newsList[index]["news"].length > 150
                            ? 148
                            : newsList[index]["news"].length),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: newsList[index]["news"].length <= 50
                        ? "\n\n\n\n\t\t\t\t"
                        : (newsList[index]["news"].length <= 100
                            ? "\n\n\n\t\t\t\t"
                            : (newsList[index]["news"].length <= 150
                                ? "\n\n\t\t\t\t"
                                : "...\n\n\t\t\t\t")),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                      text: newsList[index]["time"] >= 60
                          ? (newsList[index]["time"] ~/ 60).toString()
                          : newsList[index]["time"].toString(),
                      style: const TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      )),
                  TextSpan(
                      text: newsList[index]["time"] >= 60
                          ? (newsList[index]["time"] >= 120
                              ? " hrs ago"
                              : " hr ago")
                          : " mins ago",
                      style: const TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ))
                ]),
            textAlign: TextAlign.left,
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
          )),
    );
  }

  int getCount() {
    return newsList.length;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(102, 232, 116, 97),
        elevation: 0,
        centerTitle: true,
        title: const Text('RedBack Information'),
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
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: getTopButtons,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 100,
                    height: SizeConfig.blockSizeVertical! * 79,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(5.0),
                        scrollDirection: Axis.vertical,
                        itemCount: getCount(),
                        itemBuilder: getData),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class AboutUsPage extends InformationPage {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget getTopButtons(context, index) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
      width: 100,
      height: 20,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: index == 1
                ? const Color.fromARGB(255, 232, 116, 97)
                : const Color.fromARGB(102, 232, 116, 97),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0))),
        onPressed: () {
          index != 1 ? Navigator.of(context).pop() : null;
          index != 1
              ? (index == 0
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InformationPage()))
                  : (index == 2
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ContactPage()))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const FAQPage()))))
              : null;
        },
        child: Text(
          pages[index],
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget getData(context, index) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      width: double.infinity,
      height: 200,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 232, 116, 97),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            alignment: Alignment.centerLeft,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutUsPage()));
          },
          child: RichText(
            text: TextSpan(
                text: "About Us\n",
                style: const TextStyle(
                  color: Color.fromARGB(255, 7, 45, 75),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(text: "\n"),
                  TextSpan(
                    text: aboutUsList[index],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const TextSpan(text: "\n\n\n\t\t\t\t"),
                ]),
            textAlign: TextAlign.left,
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
          )),
    );
  }

  @override
  int getCount() {
    return aboutUsList.length;
  }
}

class ContactPage extends InformationPage {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget getTopButtons(context, index) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
      width: 100,
      height: 20,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: index == 2
                ? const Color.fromARGB(255, 232, 116, 97)
                : const Color.fromARGB(102, 232, 116, 97),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0))),
        onPressed: () {
          index != 2 ? Navigator.of(context).pop() : null;
          index != 2
              ? (index == 0
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InformationPage()))
                  : (index == 1
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AboutUsPage()))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const FAQPage()))))
              : null;
        },
        child: Text(
          pages[index],
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget getData(context, index) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      width: double.infinity,
      height: 200,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 232, 116, 97),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            alignment: Alignment.centerLeft,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ContactPage()));
          },
          child: RichText(
            text: TextSpan(
                text: "Contact Us\n",
                style: const TextStyle(
                  color: Color.fromARGB(255, 7, 45, 75),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(text: "\n"),
                  TextSpan(
                    text: contactUsList[index],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const TextSpan(text: "\n\n\n\t\t\t\t"),
                ]),
            textAlign: TextAlign.left,
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
          )),
    );
  }

  @override
  int getCount() {
    return contactUsList.length;
  }
}

class FAQPage extends InformationPage {
  const FAQPage({Key? key}) : super(key: key);

  @override
  Widget getTopButtons(context, index) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
      width: 100,
      height: 20,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: index == 3
                ? const Color.fromARGB(255, 232, 116, 97)
                : const Color.fromARGB(102, 232, 116, 97),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0))),
        onPressed: () {
          index != 3 ? Navigator.of(context).pop() : null;
          index != 3
              ? (index == 0
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InformationPage()))
                  : (index == 1
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AboutUsPage()))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ContactPage()))))
              : null;
        },
        child: Text(
          pages[index],
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget getData(context, index) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      width: double.infinity,
      height: 200,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 232, 116, 97),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            alignment: Alignment.centerLeft,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const FAQPage()));
          },
          child: RichText(
            text: TextSpan(
                text: "Question ",
                style: const TextStyle(
                  color: Color.fromARGB(255, 7, 45, 75),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                      text: (index + 1).toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 7, 45, 75),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  const TextSpan(text: "\n\n"),
                  TextSpan(
                    text: faqList[index],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const TextSpan(text: "\n\n\n\t\t\t\t"),
                ]),
            textAlign: TextAlign.left,
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
          )),
    );
  }

  @override
  int getCount() {
    return faqList.length;
  }
}
