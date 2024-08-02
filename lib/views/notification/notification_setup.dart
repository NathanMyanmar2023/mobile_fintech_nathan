// import 'dart:io';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class NotificationSetup {
//   final FirebaseMessaging _FirebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> initializeNotification() async {
//     AwesomeNotifications().initialize('resource://drawable/notification_icon', [
//       NotificationChannel(channelKey: "high_importace_channel", channelName: "channelName", channelDescription: "channelDescription",
//         importance: NotificationImportance.Max,
//         vibrationPattern: highVibrationPattern,
//         channelShowBadge: true,
//       ),
//     ]);
//     AwesomeNotifications().isNotificationAllowed().then((isAllow) {
//       if(!isAllow) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//   }
//
//   void configurePushNotifications(BuildContext context) async {
//     initializeNotification();
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     if (Platform.isIOS) getIOSPermission();
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
//       print("messg body ${message.notification!.body}");
//       if(message.notification != null){
//         createOrderNotifications(
//           title: message.notification!.title,
//           body: message.notification!.body,
//         );
//       }
//     });
//     // Handling a notification click event when the app is in the background
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint(
//           'onMessageOpenedApp: ${message.notification!.title.toString()}');
//       _handleNotificationClick(context, message);
//     });
//   }
//   // Handling a notification click event by navigating to the specified screen
//   void _handleNotificationClick(BuildContext context, RemoteMessage message) {
//     final notificationData = message.data;
//
//     if (notificationData.containsKey('screen')) {
//       final screen = notificationData['screen'];
//       Navigator.of(context).pushNamed(screen);
//     }
//   }
//   Future<void> createOrderNotifications({String? title, String? body}) async {
//     await AwesomeNotifications().createNotification(content: NotificationContent(id: 0, channelKey: 'high_importace_channel', title: title, body: body,));
//   }
//
//   void eventListenerCallback(BuildContext context) {
//     AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
//   }
//
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(ReceivedNotification receivedNotification) async {
//
//   }
//   void getIOSPermission() {
//     _FirebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       provisional: false,
//     );
//   }
// // Handler for background messages
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   debugPrint('Handling a background message: ${message.notification!.title}');
// }
// }
//
//
// class NotificationController {
// }

import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';

class MessagingService {
  static String? fcmToken; // Variable to store the FCM token

  static final MessagingService _instance = MessagingService._internal();

  factory MessagingService() => _instance;

  MessagingService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initializeNotification(BuildContext context) async {
    AwesomeNotifications().initialize('resource://drawable/notification_icon', [
      NotificationChannel(
        channelKey: "sound_channel", channelName: "Notifications",
        channelDescription: "FNGC",
        importance: NotificationImportance.High,
        vibrationPattern: highVibrationPattern,
        channelShowBadge: true,
        // criticalAlerts: true,
        playSound: true,
        onlyAlertOnce: true,
        defaultPrivacy: NotificationPrivacy.Private,
        defaultColor: colorPrimary,
        ledColor: colorPrimary,
        icon: "resource://drawable/notification_icon",
      ),
    ]);
    AwesomeNotifications().isNotificationAllowed().then((isAllow) {
      if (!isAllow) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future<void> init(BuildContext context) async {
    // Requesting permission for notifications
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
        'User granted notifications permission: ${settings.authorizationStatus}');

    // Retrieving the FCM token
    fcmToken = await _fcm.getToken();
    log('fcmToken: $fcmToken');

    // Handling background messages using the specified handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listening for incoming messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.notification!.title.toString()}');

      if (message.notification != null) {
        createOrderNotifications(
          title: message.notification!.title,
          body: message.notification!.body,
        );
        // Handling a notification click event when the app is in the background
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          debugPrint(
              'onMessageOpenedApp: ${message.notification!.title.toString()}');
          _handleNotificationClick(context, message);
        });
      }
    });

    // Handling the initial message received when the app is launched from dead (killed state)
    // When the app is killed and a new notification arrives when user clicks on it
    // It gets the data to which screen to open
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("getting");
      if (message != null) {
        _handleNotificationClick(context, message);
      }
    });
  }
  //   void eventListenerCallback(BuildContext context) {
//     AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
//   }

  Future<void> createOrderNotifications({String? title, String? body}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 0,
      channelKey: 'sound_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.BigPicture,
      bigPicture: 'images/nathan.png',
    ));
  }

  // Handling a notification click event by navigating to the specified screen
  void _handleNotificationClick(BuildContext context, RemoteMessage message) {
    final notificationData = message.data;
    print("notiit Dat $notificationData");
    // if (notificationData.containsKey('screen')) {
    //   final screen = notificationData['screen'];
    //   Navigator.of(context).pushNamed(screen);
    // }
  }
}

// Handler for background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message: ${message.notification!.title}');
  if (message.notification != null) {
    //No need for showing Notification manually.
    //For BackgroundMessages: Firebase automatically sends a Notification.
    //If you call the flutterLocalNotificationsPlugin.show()-Methode for
    //example the Notification will be displayed twice.
  }
  return;
}
