import 'package:flutter/material.dart';
import 'package:stay_safe/src/helpers/style.dart';

class CriminalScreen extends StatefulWidget {
  static String id = 'criminal_screen';
  @override
  _CriminalScreenState createState() => _CriminalScreenState();
}

class _CriminalScreenState extends State<CriminalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criminals'),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: null,
        // actions: [Icon(Icons.notifications)],
      ),
      body: ListView(
        children: [
          Text('Watch out!! Armed and Dangerous', textAlign: TextAlign.center,),
          Text('Watch out!! Armed and Dangerous',),
        ],
      ),
    );
  }
}