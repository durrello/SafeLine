import 'package:flutter/material.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/screens/welcome/onboarding_screen.dart';

//imported screens

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OnboardingScreen()),
            ));
  }
  //  nextScreen() async {
  //   getVisitingFlag() async {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     bool alreadyVisited = preferences.getBool("alreadyVisited") ?? false;
  //     return alreadyVisited;
  //   }

  //   setVisitingFlag() async {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     preferences.setBool("alreadyVisited", true);
  //   }

  //   bool visitingFlag = await getVisitingFlag();
  //   setVisitingFlag();

  //   if (visitingFlag == true) {
  //     await Navigator.pushNamed(context, HomeScreen.id);
  //   } else {
  //     await Navigator.pushNamed(context, OnboardingScreen.id);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logoRed.png'),
              Text('Stay Safe')
            ],
          ),
        ),
      ),
    );
  }
}
