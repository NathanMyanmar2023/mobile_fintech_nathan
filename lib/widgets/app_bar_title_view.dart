import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:nathan_app/widgets/nathan_text_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/shared_pref.dart';
import '../resources/colors.dart';

class AppBarTitleView extends StatefulWidget {
  final String? text;
   AppBarTitleView({Key? key, required this.text}) : super(key: key);

  @override
  State<AppBarTitleView> createState() => _AppBarTitleViewState();
}

class _AppBarTitleViewState extends State<AppBarTitleView> {

  String APP_STORE_URL = "https://apps.apple.com/mm/app/1664gym/id1664655431";
  String PLAY_STORE_URL = "https://play.google.com/store/apps/details?id=com.fintech.app.nathan";

  void goBack() {
    Navigator.pop(context);
    Navigator.pop(context);
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    Future<bool> showExist(BuildContext context) async {

      String? newVersion = await SharedPref.getData(key: SharedPref.newVersion);
      print("nee $newVersion");String message =
          "Please update to countiue using the app.\n We have launched new feature.";
      String btnLabel = "Update Now";
      String btnLabelCancel = "Later";
      newVersion == "true" ?
      await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
                child: Text(
                  "App Update Required!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: colorPrimary,
                  ),
                )),
            // content:  AlertVersionInfoView(),
            content: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // margin: const EdgeInsets.only(top: 10),
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NathanTextView(
                    text: message,
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () => goBack(),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        child: Text(btnLabelCancel),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        child: Text(
                          btnLabel,
                          style: TextStyle(color: colorWhite),
                        ),
                        onPressed: () => _launchURL(PLAY_STORE_URL),
                        style:
                        ElevatedButton.styleFrom(backgroundColor: colorPrimary),
                      ),
                    ],
                  )
                ],
              ),
            ),
            backgroundColor: colorWhite,
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.only(top: 15),
            surfaceTintColor: Colors.transparent,
          );
        },
      )
      :
      Navigator.pop(context);
      return true;
    }
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showExist(context);
        return shouldPop ?? false;
      },
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: colorPrimary,
          ),
          onPressed: () async{
            await showExist(context);
          },
        ),
        title: Text(
          "${widget.text}",
          style: const TextStyle(
            fontSize: 18,
            color: colorPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
            ),
    );
  }
}
