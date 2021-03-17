import 'package:flutter/material.dart';

//imported 3rd party packages

Color primaryColor = Color(0xffff1616);
Color aboutColor = Color(0xffF4F6FC);
Color bgColor = Color(0xfff6f6f6);
Color blue = Colors.blue;
Color black = Colors.black;
Color grey = Colors.grey;
Color white = Colors.white;
Color red = Colors.redAccent;
Color yellow = Colors.yellow;
Color green = Colors.green;

//for onboarding
final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  height: 1.2,
);
//end

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const TextFieldDecoration = InputDecoration(
  hintText: 'Enter value',
  hintStyle: TextStyle(
    color: Color(0xffff1616)
  ),
  labelText: 'Enter value',
  labelStyle: TextStyle(
    color: Color(0xffff1616)
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffff1616), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffff1616), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
