import 'package:flutter/material.dart';
import 'package:stay_safe/src/helpers/style.dart';

class Contact extends StatefulWidget {
  static String id = 'contact_screen';
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate App'),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: null,
        // actions: [Icon(Icons.notifications)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contact Us')
            ],
          ),
        ),
      ),
    );
  }
}
