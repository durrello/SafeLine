import 'package:flutter/material.dart';

List<PageModel> pages = [
  PageModel(
    icon: Icons.place,
    title: 'Watch your neighborhood',
    subtitle: "Keep track of all the incidents happening around",
    img: 'assets/images/logoWhite.png',
  ),
  PageModel(
    icon: Icons.stars,
    title: 'Report Suspicious activity',
    subtitle:
        "Robbery, Rape, Kidnapping, Missing person, Stolen items Muder,",
    img: 'assets/images/logoRed.png',
  ),
  PageModel(
    icon: Icons.favorite,
    title: 'Report Incidents',
    subtitle:
        "With the click of a button let others know what is happening around you",
    img: 'assets/images/logoRed.png',
  ),
];

class PageModel {
  final IconData icon;
  final String title, subtitle, img;

  PageModel({this.icon, this.title, this.subtitle, this.img});
}
