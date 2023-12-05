import 'package:flutter/material.dart';
import 'package:redback_mobile_app/Registration/log_in.dart';
import 'package:redback_mobile_app/Registration/sign_up.dart';
import 'package:redback_mobile_app/Utils/size_config.dart';
import 'package:sign_button/sign_button.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomePage(title: 'Redback Operations'),
    );
  }
}

//WelcomePage is made Stateful.
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

//setState can be used here inside of another method which does something.
class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE87461),
              Color.fromARGB(255, 99, 37, 126),
              //Color.fromARGB(255, 239, 136, 120),
              Color(0xff380E4A),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal! * 17,
                  ),
                  child: SizedBox(
                    height: SizeConfig.blockSizeVertical! * 28,
                    child: //Loaded the logo from assets folder and places it at the top of the screen.
                        Image.asset(
                      'assets/images/redbacklogo.png',
                      height: SizeConfig.blockSizeVertical! * 28,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 2.6,
                ),
                Text(
                  'WALK AND GET',
                  style: const TextStyle(fontWeight: FontWeight.w700).copyWith(
                    color: const Color(0xFFE87461),
                    fontSize: SizeConfig.blockSizeHorizontal! * 8,
                  ),
                ),
                Text(
                  'REWARDED',
                  style: const TextStyle(fontWeight: FontWeight.w700).copyWith(
                    color: const Color(0xFFE87461),
                    fontSize: SizeConfig.blockSizeHorizontal! * 8,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 2.6,
                ),
                //Agreement text for user. Text.rich is used so that we can use TextSpan rather
                //using simple text. This allows us to break the text into parts and apply
                //different styling to them.
                Text.rich(
                  TextSpan(
                    text: 'Earn SSG coins for every setup you take',
                    style:
                        const TextStyle(fontWeight: FontWeight.w500).copyWith(
                      color: const Color(0xFFE87461),
                      fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                    ),
                    //Adding specifically underlined text.
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 9,
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        fixedSize: Size(SizeConfig.blockSizeHorizontal! * 87,
                            SizeConfig.blockSizeVertical! * 7.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // <-- Radius
                        ),
                        foregroundColor: Colors.white,
                        // minimumSize: const Size(320, 50),
                        backgroundColor: const Color(0xFFE87461),
                      ),
                      child: Text(
                        'Sign Up',
                        style: const TextStyle(fontWeight: FontWeight.w600)
                            .copyWith(
                                fontSize: SizeConfig.blockSizeHorizontal! * 5),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1.5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // <-- Radius
                        ),
                        foregroundColor: Colors.white,
                        minimumSize: Size(SizeConfig.blockSizeHorizontal! * 87,
                            SizeConfig.blockSizeVertical! * 7.5),
                        backgroundColor:
                            const Color.fromARGB(255, 163, 76, 207),
                      ),
                      child: Text(
                        'Sign In',
                        style: const TextStyle(fontWeight: FontWeight.w600)
                            .copyWith(
                                fontSize: SizeConfig.blockSizeHorizontal! * 5),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 4,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'OR WITH',
                          style:
                              TextStyle(fontWeight: FontWeight.w700).copyWith(
                            color: const Color(0xFFE87461),
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SignInButton.mini(
                              buttonType: ButtonType.google,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen(),
                                  ),
                                );
                              },
                            ),
                            SignInButton.mini(
                              buttonType: ButtonType.github,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen(),
                                  ),
                                );
                              },
                            ),
                            SignInButton.mini(
                              buttonType: ButtonType.facebook,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 4,
                        ),
                        Text(
                          'Terms & Conditions & Privacy Policy',
                          style: TextStyle(fontWeight: FontWeight.w600)
                              .copyWith(
                                  color: const Color(0xFFE87461),
                                  //Color.fromARGB(106, 43, 80, 1),
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal! * 4),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
