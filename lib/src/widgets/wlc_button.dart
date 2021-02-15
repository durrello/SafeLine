import 'package:flutter/material.dart';

import '../helpers/style.dart';

class WelcomeButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color titleColor;
  final Function onPressed;

  const WelcomeButton(
      {Key key, this.title, this.color, @required this.onPressed, this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 6.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(title, style: TextStyle(color: titleColor ?? bgColor),),
        ),
      ),
    );
  }
}
