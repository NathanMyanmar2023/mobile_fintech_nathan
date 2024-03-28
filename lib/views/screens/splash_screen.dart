import 'package:flutter/material.dart';
import 'package:nathan_app/helpers/shared_pref.dart';
import 'package:nathan_app/views/screens/main_screen.dart';
import 'package:nathan_app/views/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String id = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      await SharedPref.getData(key: SharedPref.token).then((token) => {
            if (token.toString() != "null" && token != null)
              {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) {
                  return const MainScreen();
                }), (route) => false)
              }
            else
              {
                Navigator.pushNamed(context, WelcomeScreen.id),
              }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            'assets/app_logo.jpeg',
            width: 170,
          ),
        ),
      ),
    );
  }
}
