import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/screens/home/home.dart';
import 'package:stay_safe/src/widgets/wlc_button.dart';

class ReportIncident extends StatefulWidget {
  static String id = 'report_screen';

  @override
  _ReportIncidentState createState() => _ReportIncidentState();
}

class _ReportIncidentState extends State<ReportIncident> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

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

  //get crime information and send to firebase
  DateTime crimeDateTime = DateTime.now();
  String _injury = 'No';
  String incidentSummary;
  String injurySummary;
  String _chosenCrime = 'Robbery';

  //adding form validation
  final _formKey = GlobalKey<FormState>();

  collectCrimeInfo() async {
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");

    //  //StorageTasksnapshot
    //   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child("blogImage").child(_image.path);
    //   firebase_storage.UploadTask task = ref.putFile(_image);
    //   final storageTaskSnapshot = await task;
    //   String downloadurl = await storageTaskSnapshot.ref.getDownloadURL();
    //   url= downloadurl;
    //   //TaskSnapshot
    //   CollectionReference blogs = FirebaseFirestore.instance.collection('blogs');
    //   CrudMethods crudMethods = new CrudMethods();

    //      Map<String, String> blogData ={
    //       'imgUrl': url,
    //     };

    //      crudMethods.addData( blogData);

    Firestore.instance.collection('markers').add({
      'coords': new GeoPoint(position.latitude, position.longitude),
      // 'reporter': userEmail,
      'incident': _chosenCrime.toString(),
      'injured': _injury,
      'injurySummary'
          'summary': incidentSummary,
      // 'incident2': _chosenCrime.toString(),
      'location': first.addressLine.toString(),
      'date': crimeDateTime.toIso8601String(),
    });
    // .then((value) => LatLng(position.latitude, position.longitude));
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Report Incident'),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: null,
        // actions: [Icon(Icons.notifications)],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10),
          color: white,
          child: ListView(children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ListTile(
                title: Text('Reporter'),
                subtitle: Text(userEmail),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Select Incident Type: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    value: _chosenCrime,
                    //elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Robbery',
                      'Fire Outbreak',
                      'Power Line Down'
                          'Rape',
                      'Kidnapping',
                      'Car Theft',
                      'Assualt',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value ?? 'Not made available',
                        child: Text(
                          value,
                          style: TextStyle(color: black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      'Crime Type',
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
                ],
              ),
              Divider(),
              TextFormField(
                decoration: TextFieldDecoration.copyWith(
                    hintText: 'Please explain:', labelText: 'Summary'),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  incidentSummary = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Summary is required!';
                  }
                  if (value.length < 30) {
                    return 'Summary must be atleast 30 characters';
                  }
                  return null;
                },
              ),
              Divider(),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Any Injuries or damage? ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    focusColor: primaryColor,
                    value: _injury,
                    //elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Yes',
                      'No',
                      'Maybe',
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
                      'Any Injuries or damage?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _injury = value;
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                decoration: TextFieldDecoration.copyWith(
                    hintText: 'If yes or maybe Explain', labelText: 'If yes or maybe Explain'),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  injurySummary = value;
                },
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return 'Explanation is required!';
                //   }
                //   if (value.length < 25) {
                //     return 'Explanation must be atleast 25 characters';
                //   }
                //   return null;
                // },
              ),
              Divider(),
              WelcomeButton(
                title: 'Report',
                color: primaryColor,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _globalKey.currentState.showSnackBar(SnackBar(
                      content: Text("Logged Successful"),
                    ));
                    collectCrimeInfo();
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pushNamed(context, HomeScreen.id)
                          .then((value) => setState(() {}));
                    });
                  }
                },
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}

//for picture upload
// Text('Upload photo(s)'),
// GestureDetector(
//   onTap: () {
//     getImage();
//   },
//   child: _image != null
//       ? Container(
//           height: 150,
//           width: MediaQuery.of(context).size.width,
//           margin: EdgeInsets.symmetric(horizontal: 16),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: Image.file(
//               _image,
//               fit: BoxFit.cover,
//             ),
//           ),
//         )
//       : Container(
//           margin: EdgeInsets.symmetric(horizontal: 16),
//           decoration: BoxDecoration(color: Colors.white),
//           height: 150,
//           width: MediaQuery.of(context).size.width,
//           child: Icon(Icons.add_a_photo,
//               color: Colors.black),
//         ),
// ),
// SizedBox(
//   height: 8.0,
// ),

//collect crime info

//get photo
// final picker = ImagePicker();
// // File _image;

// Future getImage() async {
//   final pickedFile = await picker.getImage(source: ImageSource.gallery);

//   setState(() {
//     if (pickedFile != null) {
//       _image = File(pickedFile.path);
//     } else {
//       String error = "The image is empty";
//     }
//   });
// }

// String url;
