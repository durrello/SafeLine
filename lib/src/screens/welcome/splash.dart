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
  // @override
  // Widget build(BuildContext context) {
  //   return new Scaffold(
  //     body: new Center(
  //       child: new Text('Loading...'),
  //     ),
  //   );
  // }

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
              // Text('Stay Safe')
            ],
          ),
        ),
      ),
    );
  }
}
