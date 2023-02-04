import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:logger/logger.dart';
import 'package:video_calling/controllers/notification_controller.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationController _notificationController = NotificationController();

  //----initialize notifications and get the device token

  Future<void> initNotifications(BuildContext context) async {
    // Get the token each time the application loads
    await FirebaseMessaging.instance.getToken().then(
      (value) {
        Logger().wtf(value);
        startSaveToken(context, value!);
      },
    );
  }

  //---save notification token in db
  Future<void> startSaveToken(BuildContext context, String token) async {
    try {
      //then start saving
      await _notificationController.saveNotificationToken(token);
    } catch (e) {
      Logger().e(e);
    }
  }

  CallKitParams callKitParams = CallKitParams(
    id: "1",
    nameCaller: 'Hien Nguyen',
    appName: 'Callkit',
    avatar: 'https://i.pravatar.cc/100',
    handle: '0123456789',
    type: 0,
    textAccept: 'Accept',
    textDecline: 'Decline',
    textMissedCall: 'Missed call',
    textCallback: 'Call back',
    duration: 30000,
    extra: <String, dynamic>{'userId': '1a2b3c4d'},
    headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
    android: const AndroidParams(
      isCustomNotification: false,
      isShowLogo: false,
      isShowCallback: false,
      isShowMissedCallNotification: true,
      ringtonePath: 'system_ringtone_default',
      backgroundColor: '#0955fa',
      backgroundUrl: 'https://i.pravatar.cc/500',
      actionColor: '#4CAF50',
      incomingCallNotificationChannelName: "Incoming Call",
      missedCallNotificationChannelName: "Missed Call",
    ),
    ios: IOSParams(
      iconName: 'CallKitLogo',
      handleType: 'generic',
      supportsVideo: true,
      maximumCallGroups: 2,
      maximumCallsPerCallGroup: 1,
      audioSessionMode: 'default',
      audioSessionActive: true,
      audioSessionPreferredSampleRate: 44100.0,
      audioSessionPreferredIOBufferDuration: 0.005,
      supportsDTMF: true,
      supportsHolding: true,
      supportsGrouping: false,
      supportsUngrouping: false,
      ringtonePath: 'system_ringtone_default',
    ),
  );

  //---handle foreground notitification
  void foregroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().w('Got a message whilst in the foreground!');
      Logger().w('Message data: ${message.data}');

      showCalling();

      if (message.notification != null) {
        Logger().wtf('Message also contained a notification: ${message.notification!.toMap()}');
      }
    });
  }

  //----handle when click on the notification and open the app
  void onClickedOpenedApp(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Logger().w('///////----------clicked notification to open the app');
      Logger().w('Message data: ${message.data}');

      showCalling();

      if (message.notification != null) {
        // Logger().wtf('Message also contained a notification: ${message.notification!.toMap()}');

      }
    });
  }

  Future<void> showCalling() async {
    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
  }
}
