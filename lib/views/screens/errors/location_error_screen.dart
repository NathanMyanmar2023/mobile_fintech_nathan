import 'package:flutter/material.dart';
import 'package:nathan_app/views/screens/splash_screen.dart';

class LocationErrorScreen extends StatelessWidget {
  const LocationErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('images/gps.png'),
              ),
              const SizedBox(height: 10),
              Text(
                "Enable Location Service!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Please enable location service and retry.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) {
                    return const SplashScreen();
                  }), (route) => false);
                },color: const Color.fromARGB(255, 63, 116, 242),
                
                child: const SizedBox(
                  height: 30,
                  width: 100,
                  child: Center(
                    child: Text(
                      'Retry',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
