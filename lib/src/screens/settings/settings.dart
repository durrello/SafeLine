import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/screens/welcome/welcome_screen.dart';
import 'package:stay_safe/src/widgets/wlc_button.dart';

class SettingScreen extends StatefulWidget {
  static String id = 'setting_screen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  //creating a new auth instance
  final _auth = FirebaseAuth.instance;
  //variables to store collected input data
  String email;
  String password;
  String error = '';
  bool showSpinner = false;
  //adding form validation
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

//sign out pop up dialog funtion
  Future<void> signOut() async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Warning',
            style: TextStyle(color: primaryColor),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to leave'),
                Text('Stay and report crime in your area'),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: primaryColor,
                        size: 40,
                      ),
                      onPressed: () => SystemChannels.platform
                          .invokeMethod<void>('SystemNavigator.pop'),
                    ),
                    SizedBox(width: 50),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.green,
                        size: 40,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ]),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: null,
        actions: [
          IconButton(
            // color: red,
            icon: Icon(
              Icons.settings_power,
            ),
            onPressed: () {
              _auth.signOut();
              signOut();
            },
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 180.0,
                      child: Image.asset('assets/images/logoWhite.png'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Update Account',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: TextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Email is required!';
                    }
                    if (!RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                        .hasMatch(value)) {
                      return 'Please Enter a valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: TextFieldDecoration.copyWith(
                      hintText: 'Enter your password', labelText: 'Password'),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password is required!';
                    }
                    if (value.length < 6) {
                      return 'Password must be atleast 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    error,
                    style: TextStyle(color: red),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                WelcomeButton(
                  title: 'Update',
                  color: primaryColor,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (newUser != null) {
                          _globalKey.currentState.showSnackBar(SnackBar(
                            content: Text("Update Successful"),
                          ));
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.pushNamed(context, WelcomeScreen.id);
                          });
                        }
                        setState(() {
                          email = newUser.email;
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          error = 'Could not sign in with those credentials';
                          showSpinner = false;
                        });
                        print(e);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
