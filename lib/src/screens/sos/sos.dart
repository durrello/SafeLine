import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stay_safe/src/helpers/style.dart';
import 'package:stay_safe/src/screens/home/home.dart';
import 'package:url_launcher/url_launcher.dart';

class SOS extends StatefulWidget {
  static String id = 'sos_screen';

  @override
  _SOSState createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Could not launch $command');
    }
  }

  Future<void> placeCall() async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            Icons.call,
            color: primaryColor,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Divider(color: primaryColor),
                InkWell(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('POLICE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        trailing: Icon(
                          Icons.person_outline,
                          color: blue,
                        ),
                      )),
                  onTap: () {
                    print('call police');
                    customLaunch('tel: 117');
                  },
                ),
                Divider(color: primaryColor),
                InkWell(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('HOSPITAL',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        trailing: Icon(
                          FontAwesomeIcons.hospital,
                          color: red,
                        ),
                      )),
                  onTap: () {
                    print('call hospital');
                    customLaunch('tel: 119');
                  },
                ),
                Divider(color: primaryColor),
                InkWell(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('FIRE BRIGADE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        trailing: Icon(
                          FontAwesomeIcons.fire,
                          color: Colors.yellow,
                        ),
                      )),
                  onTap: () {
                    print('call fire brigade');
                    customLaunch('tel: 118');
                  },
                ),
                Divider(color: primaryColor)
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('SOS'),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: null,
        // actions: [Icon(Icons.notifications)],
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'EMERGENCY?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  placeCall();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/sos.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, HomeScreen.id)
                          .then((value) => setState(() {}));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
