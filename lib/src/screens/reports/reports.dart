import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/screens/home/home.dart';

class ReportsScreen extends StatefulWidget {
  static String id = 'reports_screen';
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  //loggin user in
  String userEmail = '';
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        setState(() {
          userEmail = loggedInUser.email;
          // setMarkers();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  List<bool> isSelected;
  @override
  void initState() {
    isSelected = [true, false];
    super.initState();

    //get current user
    getCurrentUser();
    _getReports();
  }

//get reports from firebase
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _markers = [];
  bool _loadinMarkers = true;

  //function to get reports
  _getReports() async {
    // Query q = _firestore.collection('markers');
    Query q = _firestore
        .collection('markers')
        .orderBy('date', descending: true)
        .limit(10);

    setState(() {
      _loadinMarkers = true;
    });
    QuerySnapshot querySnapshot = await q.getDocuments();
    _markers = querySnapshot.documents;
    setState(() {
      _loadinMarkers = false;
    });
  }

  _getReportsNearMe() async {
    // Query q = _firestore.collection('markers');
    Query q = _firestore
        .collection('markers')
        .orderBy('location', descending: true)
        .limit(10);

    setState(() {
      _loadinMarkers = true;
    });
    QuerySnapshot querySnapshot = await q.getDocuments();
    _markers = querySnapshot.documents;
    setState(() {
      _loadinMarkers = false;
    });
  }

  String getreportText = 'Near me';

  toggleReport() {}
//end login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: null,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () => Navigator.pushNamed(context, HomeScreen.id)
                    .then((value) => setState(() {}))),
          )
        ],
      ),
      body: _loadinMarkers == true
          ? Container(
              child: Center(
                child: Text('Loading Reports'),
              ),
            )
          : Container(
              child: _markers.length == 0
                  ? Center(
                      child: Text('No Reports found'),
                    )
                  : ListView.builder(
                      itemCount: _markers.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return
                            // GestureDetector(
                            // onTap: () {
                            //   Navigator.pushNamed(
                            //       context, ReportDetailsScreen.id);
                            // },
                            // child:
                            ListTile(
                          leading: Image.network('${_markers[index].data['url']}'),
                          title: Text('${_markers[index].data['incident']}'),
                          subtitle: Text('${_markers[index].data['location']}'),
                          // trailing: ,
                          // trailing: Text("${_markers[index].data['date'].toDate().toString()}"),
                        );
                        // );
                      }),
            ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 0, 15),
        child: ToggleButtons(
          borderColor: primaryColor,
          fillColor: primaryColor,
          borderWidth: 2,
          selectedBorderColor: primaryColor,
          selectedColor: Colors.white,
          borderRadius: BorderRadius.circular(0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Near me',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Latest',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                // isSelected[i] = i == index;
                if (i == index) {
                  isSelected[i] = true;
                  _getReports();
                } else {
                  isSelected[i] = false;
                  _getReportsNearMe();
                }
              }
            });
          },
          isSelected: isSelected,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
