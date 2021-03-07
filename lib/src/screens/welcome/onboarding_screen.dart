import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/models/page_models.dart';
import 'package:stay_safe/src/screens/auth/login_screen.dart';
import 'package:stay_safe/src/screens/welcome/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static String id = 'onboarding_screen';
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with AfterLayoutMixin<OnboardingScreen> {
   Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new WelcomeScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();
  
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              pages[currentIndex].img,
              fit: BoxFit.contain,
            ),
            Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                onPressed: () =>
                    Navigator.pushNamed(context, WelcomeScreen.id),
                child: Text('Skip',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: size.height * .4,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView(children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            pages[currentIndex].icon,
                            color: Colors.red[500],
                            size: 40,
                          ),
                          Text(
                            pages[currentIndex].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Container(
                            width: size.width * .6,
                            child: Text(
                              pages[currentIndex].subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          Container(
                            width: size.width * .8,
                            height: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (currentIndex < 2)
                                        currentIndex++;
                                      else if (currentIndex == 2) {
                                        Navigator.pushNamed(
                                            context, WelcomeScreen.id);
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: currentIndex == 2
                                          ? Colors.red[500]
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          currentIndex == 2
                                              ? "Let's Start"
                                              : "Next",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: currentIndex == 2
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 10,
                                width: 10,
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == 0
                                      ? Colors.black
                                      : Colors.grey[300],
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 10,
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == 1
                                      ? Colors.black
                                      : Colors.grey[300],
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 10,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == 2
                                      ? Colors.black
                                      : Colors.grey[300],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}