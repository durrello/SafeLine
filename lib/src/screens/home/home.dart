import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
// import 'package:share/share.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/screens/about/about.dart';
import 'package:stay_safe/src/screens/home/report_incident.dart';
import 'package:stay_safe/src/screens/notification/notifications.dart';
import 'package:stay_safe/src/screens/rate_app/rate.dart';
import 'package:stay_safe/src/screens/reports/reports.dart';
import 'package:stay_safe/src/screens/settings/settings.dart';
import 'package:stay_safe/src/screens/sos/sos.dart';
import 'package:stay_safe/src/widgets/drawer_option.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //firbase messaging
  String token = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  //for bottom navigation
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   // loadMap()
  //   MapScreen(),
  //   ReportsScreen()
  // ];
  // void onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

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

  @override
  void initState() {
    //firebase messaging
    getToken();

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            alert: true, badge: true, provisional: true, sound: true));

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //_showItemDialog(message);
      },
      //onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );
    super.initState();

    //run t go to user location after 3 seconds
    new Future.delayed(const Duration(seconds: 3), () async {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((value) => {
            controller.move(LatLng(value.latitude, value.longitude), 17.0),
            print(value)
          });
    });
    //get current user
    getCurrentUser();
  }

//firebase messaging
  void getToken() async {
    token = await firebaseMessaging.getToken();
  }

//map
  List<Marker> allMarkers = [];
  setMarkers() {
    return allMarkers;
  }

//get current location
  MapController controller = MapController();

//get and move to current location
  void myLocation() async {
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).then((value) => {
          controller.move(LatLng(value.latitude, value.longitude), 17.0),
          print(value)
        });
  }

  color(snapshot) {
    if (snapshot['state'] == false && snapshot['status'] == false) {
      return primaryColor;
    }
    if (snapshot['state'] == false && snapshot['status'] == true) {
      return yellow;
    }
    if (snapshot['state'] == true && snapshot['status'] == false) {
      return yellow;
    }
    if (snapshot['state'] == true && snapshot['status'] == true) {
      return green;
    }
  }

  Widget loadMap() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('markers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: primaryColor,
                ),
                Text('Loading Please wait'),
              ],
            ),
          );
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          allMarkers.add(
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(
                snapshot.data.documents[i]['coords'].latitude,
                snapshot.data.documents[i]['coords'].longitude,
              ),
              builder: (context) => Container(
                child: IconButton(
                  icon: Icon(Icons.location_on),
                  color: color(snapshot.data.documents[i]),
                  iconSize: 45,
                  onPressed: () {
                    return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('markers')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        backgroundColor: primaryColor,
                                      ),
                                      Text('Loading Please wait'),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  height: 100,
                                  child: ListView(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            color: primaryColor,
                                          ),
                                          Text(
                                            'Report',
                                            style:
                                                TextStyle(color: primaryColor),
                                          )
                                        ],
                                      ),
                                      ListTile(
                                        title: Row(
                                          children: [
                                            Text(snapshot.data.documents[i]
                                                    ['incident'] ??
                                                'Not available'),
                                            Spacer(),
                                            Text(
                                              snapshot.data.documents[i]
                                                      ['status-text'] ??
                                                  'Not available',
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                        subtitle: Text(snapshot.data
                                                .documents[i]['location'] ??
                                            'Not available'),
                                        leading: Image.network(snapshot
                                                .data.documents[i]['url']
                                                .toString() ??
                                            Image.asset(
                                                'assets/images/logoRed.png')),
                                        // trailing:
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          actions: [
                            FlatButton(
                              child: Text('Reports'),
                              onPressed: () {
                                Navigator.pushNamed(context, ReportsScreen.id);
                              },
                            ),
                            FlatButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }
        return FlutterMap(
          mapController: controller,
          options: MapOptions(
            center: LatLng(4.1560, 9.2632),
            minZoom: 0.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/durrellgemuh/ckhvuomdt08mw19ruk45zjs9f/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZHVycmVsbGdlbXVoIiwiYSI6ImNraHVlMmlpZDA0ZXYyc28yZmY3Zmh5cTIifQ.GGPGj6C2pE-L1LasAQNc7A",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoiZHVycmVsbGdlbXVoIiwiYSI6ImNraTc2M3VvbjFmbmcyc3FzY2YwZGVtZjQifQ.Wva0b4DyjCguSZXcXm5y3A',
                'id': 'mapbox.mapbox-streets-v8'
              },
            ),
            MarkerLayerOptions(
              markers: allMarkers,
            )
          ],
        );
      },
    );
  }

  //main function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        title: Text(
          "SafeLine",
          textAlign: TextAlign.end,
        ),
        actions: [
          FlatButton(
            onPressed: () {
              myLocation();
              print(token);
            },
            child: Container(
              child: Row(children: [
                IconButton(
                  onPressed: myLocation,
                  icon: Icon(
                    Icons.navigation,
                    color: white,
                  ),
                ),
                Text(
                  'Me',
                  style: TextStyle(color: white),
                )
              ]),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            //header
            UserAccountsDrawerHeader(
              accountName: Text("Username"),
              accountEmail: Text(userEmail),
              currentAccountPicture: GestureDetector(
                child:
                    Expanded(child: Image.asset('assets/images/logoRed.png')),
              ),
              decoration: BoxDecoration(
                color: primaryColor,
              ),
            ),

            //body
            DrawerOption(
              text: "SOS",
              iconData: Icons.book,
              onPressed: () => Navigator.pushNamed(context, SOS.id)
                  .then((value) => setState(() {})),
            ),

            Divider(
              thickness: 1,
              color: primaryColor,
            ),

            DrawerOption(
              text: "Notifications",
              iconData: Icons.notifications,
              onPressed: () {
                Navigator.pushNamed(context, Notifications.id);
              },
            ),
            DrawerOption(
              text: "Reports",
              iconData: Icons.book,
              onPressed: () => Navigator.pushNamed(context, ReportsScreen.id)
                  .then((value) => setState(() {})),
            ),

            // DrawerOption(
            //   text: "Notifications",
            //   iconData: Icons.chat,
            //   onPressed: () {
            //     Navigator.pushNamed(context, ChatScreen.id);
            //   },
            // ),

            DrawerOption(
              text: "Rate App",
              iconData: Icons.star,
              onPressed: () {
                Navigator.pushNamed(context, RateMyApp.id);
              },
            ),

            // DrawerOption(
            //   text: "Share App",
            //   iconData: Icons.share,
            //   onPressed: () {
            //     Share.share(
            //         'SafeLine is a mobile application which was developed to fight crime and reduce incident rate in our individual communities. \n Keep your community safe \n SafeLine',
            //         subject: 'Download the App!');
            //     // share();
            //   },
            // ),

            // DrawerOption(
            //   text: "Contact Us",
            //   iconData: Icons.info,
            //   onPressed: () {
            //     Navigator.pushNamed(context, Contact.id);
            //   },
            // ),

            DrawerOption(
              text: "Setting",
              iconData: Icons.settings,
              onPressed: () {
                Navigator.pushNamed(context, SettingScreen.id);
              },
            ),

            DrawerOption(
              text: "About",
              iconData: Icons.info,
              onPressed: () {
                Navigator.pushNamed(context, AboutScreen.id);
              },
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
            Column(
              children: [
                Text('Version'),
                Text('1.0'),
                SizedBox(
                  height: 10,
                ),
                IconButton(
                  color: red,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 0, 15),
        child: FloatingActionButton.extended(
          label: Text('Report'),
          icon: Icon(Icons.add),
          backgroundColor: primaryColor,
          onPressed: () => Navigator.pushNamed(context, ReportIncident.id),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // body: _children[_currentIndex],
      body: loadMap(),
    );
  }
}
