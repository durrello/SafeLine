import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/screens/auth/login_screen.dart';
import 'package:stay_safe/src/screens/home/home.dart';
import 'package:stay_safe/src/widgets/wlc_button.dart';

class RegistrationScreen extends StatefulWidget {
  //id used for routing
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  //creating a new auth instance
  final _auth = FirebaseAuth.instance;
  //variables to store collected input data
  String email;
  String password;
  String error = '';

  //variable for spinner
  bool showSpinner = false;

  //adding form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: bgColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('assets/images/logoWhite.png'),
                    ),
                  ),
                ),
                  Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Register',
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
                  title: 'Register',
                  color: primaryColor,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                           _globalKey.currentState.showSnackBar(SnackBar(
                            content: Text("Registration Successful"),
                          ));
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.pushNamed(context, HomeScreen.id);
                          });
                        }
                        setState(() {
                          email = newUser.email;
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          error = 'User already exists';
                          showSpinner = false;
                        });
                        print(e);
                      }
                    }
                  },
                ),
                FlatButton(
                  onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
                  child: Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
