import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/screens/home/home.dart';
import 'package:stay_safe/src/widgets/wlc_button.dart';

class RateMyApp extends StatefulWidget {
  static String id = 'rateApp_screen';

  @override
  _RateMyAppState createState() => _RateMyAppState();
}

class _RateMyAppState extends State<RateMyApp> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  bool isExitVisible = false;

  //rating
  var myFeedBackText = 'COULD BE BETTER';
  var sliderValue = 1.0;
  IconData myFeedBack = FontAwesomeIcons.sadTear;
  Color myFeedBackColor = red;

  //function to send rating
  sendRate() {
    Firestore.instance.collection('ratings').add({'rate': myFeedBackText});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Rate App'),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: null,
        // actions: [Icon(Icons.notifications)],
      ),
      body: Container(
        color: white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: Text(
                      'On a scale of 1 to 5 \n What would you give our App?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(20),
                child: Align(
                  child: Material(
                    color: white,
                    elevation: 15,
                    borderRadius: BorderRadius.circular(24),
                    shadowColor: red,
                    child: Container(
                      width: 340,
                      height: 320,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Text(
                              '$myFeedBackText',
                              style: TextStyle(color: black),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Icon(
                              myFeedBack,
                              color: myFeedBackColor,
                              size: 100,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Slider(
                                min: 0,
                                max: 5,
                                value: sliderValue,
                                divisions: 5,
                                activeColor: blue,
                                inactiveColor: grey,
                                onChanged: (newValue) {
                                  setState(() {
                                    sliderValue = newValue;
                                    if (sliderValue >= 0.0 &&
                                        sliderValue <= 1.0) {
                                      myFeedBack = FontAwesomeIcons.sadTear;
                                      myFeedBackColor = red;
                                      myFeedBackText = 'COULD BE BETTER';
                                    }
                                    if (sliderValue >= 2.0 &&
                                        sliderValue <= 3.0) {
                                      myFeedBack = FontAwesomeIcons.frown;
                                      myFeedBackColor = Colors.yellow;
                                      myFeedBackText = 'BELOW AVERAGE';
                                    }
                                    if (sliderValue >= 3.0 &&
                                        sliderValue <= 4.0) {
                                      myFeedBack = FontAwesomeIcons.smileBeam;
                                      myFeedBackColor = Colors.yellow;
                                      myFeedBackText = 'GOOD';
                                    }
                                    if (sliderValue >= 4.0 &&
                                        sliderValue <= 5.0) {
                                      myFeedBack = FontAwesomeIcons.laugh;
                                      myFeedBackColor = Colors.green;
                                      myFeedBackText = 'GREAT APP';
                                    }
                                    if (sliderValue == 5) {
                                      myFeedBack = FontAwesomeIcons.handshake;
                                      myFeedBackColor = Colors.green;
                                      myFeedBackText = 'EXCELLENT';
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                                child: Text('Your Rating: $sliderValue')),
                          ),
                          Container(
                            child: WelcomeButton(
                              title: 'SAVE',
                              titleColor: primaryColor,
                              color: bgColor,
                              onPressed: () {
                                sendRate();
                                setState(() {
                                  isExitVisible = true;
                                });
                                _globalKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Thank You for Rating our App"),
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: isExitVisible,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: WelcomeButton(
                      title: 'EXIT',
                      color: primaryColor,
                      onPressed: () =>
                          Navigator.pushNamed(context, HomeScreen.id),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
