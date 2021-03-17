import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stay_safe/src/helpers/style.dart';
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Contact any of our SOS services.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                color: primaryColor,
                thickness: 3,
              ),
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
                  customLaunch('tel: + 117');
                },
              ),
              Divider(
                color: primaryColor,
                thickness: 3,
              ),
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
                  customLaunch('tel: 119');
                },
              ),
              Divider(
                color: primaryColor,
                thickness: 3,
              ),
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
                  customLaunch('tel: 118');
                },
              ),
              Divider(
                color: primaryColor,
                thickness: 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
