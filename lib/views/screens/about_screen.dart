import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/config/config.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/resources/constants.dart';

import '../../models/utils/app_constants.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white, // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(70),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10),
        //     child: AppBar(
        //       toolbarHeight: 70,
        //       elevation: 0,
        //       backgroundColor: Colors.transparent,
        //       leading: IconButton(
        //         icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        //         onPressed: () => Navigator.of(context).pop(),
        //       ),
        //       title: const Text(
        //         "About Application",
        //         style: TextStyle(
        //           fontSize: 18,
        //           color: Colors.black,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(appLogo),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "FNGC Group of Companies",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                "VERSION $App_Version",
                style: TextStyle(
                  fontSize: 14,
                  color: colorGrey,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
