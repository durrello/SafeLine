import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stay_safe/src/screens/welcome/onboarding_screen.dart';

import 'src/screens/about/about.dart';
import 'src/screens/auth/login_screen.dart';
import 'src/screens/auth/registration_screen.dart';
import 'src/screens/chat/chat_screen.dart';
import 'src/screens/criminals/criminal.dart';
import 'src/screens/home/home.dart';
import 'src/screens/home/map.dart';
import 'src/screens/rate_app/rate.dart';
import 'src/screens/reports/reports.dart';
import 'src/screens/settings/settings.dart';
import 'src/screens/welcome/splash.dart';
import 'src/screens/welcome/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  return runApp(CrimeLine());
}

class CrimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        OnboardingScreen.id: (context) => OnboardingScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        MapScreen.id: (context) => MapScreen(),
        ReportsScreen.id: (context) => ReportsScreen(),
        CriminalScreen.id: (context) => CriminalScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        AboutScreen.id: (context) => AboutScreen(),
        RateMyApp.id: (context) => RateMyApp(),
        SettingScreen.id: (context) => SettingScreen(),
      },
    );
  }
}
