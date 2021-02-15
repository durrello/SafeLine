import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:random_color/random_color.dart';
import 'package:share/share.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/screens/about/about.dart';
import 'package:stay_safe/src/screens/chat/chat_screen.dart';
import 'package:stay_safe/src/screens/rate_app/rate.dart';
import 'package:stay_safe/src/screens/reports/reports.dart';
import 'package:stay_safe/src/screens/settings/settings.dart';
import 'package:stay_safe/src/widgets/drawer_option.dart';
import 'package:stay_safe/src/widgets/wlc_button.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RandomColor _randomColor = RandomColor();
  int crimeType = 1;
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

  String setLocationText = 'Click to get location';

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
    super.initState();

    //get current user
    getCurrentUser();
  }
//end login

//map
  List<Marker> allMarkers = [];
  setMarkers() {
    return allMarkers;
  }

//get current location
  MapController controller = MapController();

  //get crime information and send to firebase
  final locationController = TextEditingController();
  final criminalDressController = TextEditingController();
  final summaryController = TextEditingController();
  final crimeTypeController = TextEditingController();

  collectCrimeInfo() async {
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");

    Firestore.instance.collection('markers').add({
      'coords': new GeoPoint(position.latitude, position.longitude),
      'reporter': userEmail,
      // 'type': crimeTypeController.text,
      // 'dressing': criminalDressController.text,
      'summary': summaryController.text,
      'incident': _chosenCrime.toString(),
      'location': first.addressLine.toString(),
    }).then((value) => LatLng(position.latitude, position.longitude));
    return position;
  }

//get and move to current location
  void myLocation() async {
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).then((value) => {
          controller.move(LatLng(value.latitude, value.longitude), 17.0),
          print(value)
        });
  }

 
//collect crimeinfo dialog
 String _chosenCrime;
  Future addMarker() async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Report ',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primaryColor),
                ),
                Icon(
                  Icons.edit,
                  color: primaryColor,
                )
              ],
            ),
            children: [
              SimpleDialogOption(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Text('Reporter: $userEmail'),
                    SizedBox(height: 5),
                    DropdownButton<String>(
                      focusColor: Colors.white,
                      value: _chosenCrime,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: <String>[
                        'Robbery',
                        'Rape',
                        'Kidnapping',
                        'Car Theft',
                        'Assualt',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        'Crime Type' ?? _chosenCrime,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _chosenCrime = value;
                        });
                      },
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: criminalDressController,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'How is the criminal dressed',
                      ),
                    ),
                    TextField(
                      controller: summaryController,
                      // obscureText: true,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'Brief detail',
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Upload photo(s)'),
                    WelcomeButton(
                      title: 'SEND',
                      color: primaryColor,
                      onPressed: () {
                        collectCrimeInfo();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
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
                  color: _randomColor.randomColor(
                      colorBrightness: ColorBrightness.dark),
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
                                  child: ListView(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: primaryColor,
                                      ),
                                      ListTile(
                                        title: Text('Reporter: '),
                                        subtitle: Text(snapshot.data
                                                .documents[i]['reporter'] ??
                                            'Not available'),
                                      ),
                                      ListTile(
                                        title: Text('Crime Type: '),
                                        subtitle: Text(snapshot.data
                                                .documents[i]['incident'] ??
                                            'Not available'),
                                      ),
                                      ListTile(
                                        title: Text('Location: '),
                                        subtitle: Text(snapshot.data
                                                .documents[i]['location'] ??
                                            'Not available'),
                                      ),
                                      ListTile(
                                        title: Text('Summary of crime: '),
                                        subtitle: Text(snapshot
                                                .data.documents[i]['summary'] ??
                                            'Not available'),
                                      ),
                                      ListTile(
                                        title: Text('Status: '),
                                        subtitle: Text(snapshot
                                                .data.documents[i]['status'] ??
                                            'Not available'),
                                      ),
                                      ListTile(
                                        title: Text('Pictures: '),
                                        subtitle: Text(snapshot
                                                .data.documents[i]['media'] ??
                                            'HQ'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          actions: [
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
            minZoom: 0.0,
            plugins: [
              // MarkerClusterPlugin(),
            ],
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
            // MarkerClusterLayerOptions(
            //   maxClusterRadius: 120,
            //   size: Size(40, 40),
            //   fitBoundsOptions: FitBoundsOptions(
            //     padding: EdgeInsets.all(50),
            //   ),
            //   markers: allMarkers,
            //   // polygonOptions: PolygonOptions(
            //   //     borderColor: primaryColor,
            //   //     color: primaryColor,
            //   //     borderStrokeWidth: 3),
            //   builder: (context, markers) {
            //     return FloatingActionButton(
            //         backgroundColor: primaryColor,
            //         child: Text(markers.length.toString()),
            //         onPressed: null);
            //   },
            // )
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
          "Crime Line",
          textAlign: TextAlign.end,
        ),
        actions: [
          FlatButton(
            onPressed: myLocation,
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
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: primaryColor,
      //   backgroundColor: bgColor,
      //   selectedFontSize: 16,
      //   selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      //   onTap: onTabTapped, // new
      //   currentIndex: _currentIndex, // new
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.book),
      //       title: Text('News'),
      //     )
      //   ],
      // ),
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
              text: "Reports",
              // iconData: FontAwesomeIcons.userSecret,
              iconData: Icons.book,
              onPressed: () => Navigator.pushNamed(context, ReportsScreen.id)
                  .then((value) => setState(() {})),
            ),

            DrawerOption(
              text: "Notifications",
              iconData: Icons.chat,
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.id);
              },
            ),

            DrawerOption(
              text: "Rate App",
              iconData: Icons.star,
              onPressed: () {
                Navigator.pushNamed(context, RateMyApp.id);
              },
            ),

            DrawerOption(
              text: "Share App",
              iconData: Icons.share,
              onPressed: () {
                Share.share(
                    'CRIMELINE is a mobile application which was developed to fight crime in our individual communities. \n Download the App via the link provided below and help keep the community safe \n www.zuoix.com',
                    subject: 'Download the App!');
                // share();
              },
            ),

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
                Text('x.x.x.x'),
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
          onPressed: addMarker,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // body: _children[_currentIndex],
      body: loadMap(),
    );
  }
}
