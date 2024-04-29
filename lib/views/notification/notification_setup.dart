import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationSetup {
  final FirebaseMessaging _FirebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeNotification() async {
    AwesomeNotifications().initialize('resource://drawable/res_launcher_icon', [
      NotificationChannel(channelKey: "high_importace_channel", channelName: "channelName", channelDescription: "channelDescription",
        importance: NotificationImportance.Max,
        vibrationPattern: highVibrationPattern,
        channelShowBadge: true,
      ),
    ]);
    AwesomeNotifications().isNotificationAllowed().then((isAllow) {
      if(!isAllow) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  void configurePushNotifications(BuildContext context) async {
    initializeNotification();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    if (Platform.isIOS) getIOSPermission();
    // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      print("messg body ${message.notification!.body}");
      if(message.notification != null){
        createOrderNotifications(
          title: message.notification!.title,
          body: message.notification!.body,
        );
      }
    });
  }

  Future<void> createOrderNotifications({String? title, String? body}) async {
    await AwesomeNotifications().createNotification(content: NotificationContent(id: 0, channelKey: 'high_importace_channel', title: title, body: body,));
  }

  void eventListenerCallback(BuildContext context) {
    AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedNotification receivedNotification) async {

  }
  void getIOSPermission() {
    _FirebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }
  Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
  }
}


class NotificationController {
}