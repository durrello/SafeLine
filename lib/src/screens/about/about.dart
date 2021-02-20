import 'package:flutter/material.dart';
import 'package:stay_safe/src/helpers/style.dart';

class AboutScreen extends StatelessWidget {
  static String id = 'about_screen';

  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: null,
        // actions: [Icon(Icons.notifications)],
      ),
      backgroundColor: aboutColor,
      body: Center(
        child: Container(
          color: aboutColor,
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.gif'),
              Expanded(
                child: Center(
                  child: Text(
                    'CRIMELINE is a mobile application which was developed to fight crime in our local individual communities. \nCRIMELINE, a free downloadable app, provides 24-hour emergency assistance in an attempt to lower the country\'s alarming crime statistics.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
