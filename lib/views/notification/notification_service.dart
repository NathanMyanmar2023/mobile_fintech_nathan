import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static ReceivedAction? initialAction;
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
      "resource://drawable/notification_icon",
      [
        NotificationChannel(
          channelKey: "notificationChannelId",
          channelName: "channelName",
          channelDescription: "channelName",
          playSound: true,
          onlyAlertOnce: true,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: Colors.blue,
          ledColor: Colors.blue,
          icon: "resource://drawable/notification_icon",
        )
      ],
      debug: true,
    );

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction) {
      if (receivedAction.payload != null) {
        //////////////////////////////
        print(receivedAction.payload!["payload"]!);
        ////////////////////////////
      }
    } else {
      if (receivedAction.payload != null) {
        ////////////////////////
        print(receivedAction.payload!["payload"]!);
      }
    }
  }
}