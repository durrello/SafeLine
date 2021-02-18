import 'package:flutter/material.dart';
import 'package:stay_safe/src/helpers/style.dart';

class ReportDetailsScreen extends StatefulWidget {
  static String id = 'report_details_screen';
  @override
  _ReportDetailsScreenState createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: primaryColor,
            expandedHeight: 300,
            shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)), 
            ),
            flexibleSpace: FlexibleSpaceBar(
             background: Image.asset('assets/images/logoRed.png', fit: BoxFit.cover,), 
            ),
          ),
          SliverList(delegate: null)
        ],
      ),
    );
  }
}
