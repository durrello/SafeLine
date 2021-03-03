import 'package:flutter/material.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/screens/home/home.dart';
import 'package:stay_safe/src/screens/welcome/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

//imported screens

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen> with AfterLayoutMixin<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new HomeScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnboardingScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

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
