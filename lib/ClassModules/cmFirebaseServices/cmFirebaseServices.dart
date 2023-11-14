import 'dart:convert';
import 'dart:io';

import 'package:dowidardriver/ClassModules/cmHandleDeepLink/cm_HandleDeepLink.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

BuildContext? _context;

_handleOnTapNotification(message) {
  BannerNotificationPayload notificationPayload = BannerNotificationPayload.fromRawJson(message.data["payload"]);
  cm_HandleDeepLink()
      .handleDeepLink(context: _context, deeplink: notificationPayload.type!, payLoad: notificationPayload.id);
}

class FirebaseService {
  static FirebaseMessaging? _firebaseMessaging;

  static FirebaseMessaging get firebaseMessaging => FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
        options: Platform.isAndroid
            ? const FirebaseOptions(
                apiKey: "AIzaSyDX2sizGQUlA7vYnh4F_dzrx9ReF5Kjgrc",
                projectId: "dowidar-7e981",
                storageBucket: "dowidar-7e981.appspot.com",
                messagingSenderId: "583156775225",
                appId: "1:583156775225:android:8d6464b077e996aef790e8",
              )
            : const FirebaseOptions(
                apiKey: "AIzaSyDX2sizGQUlA7vYnh4F_dzrx9ReF5Kjgrc",
                projectId: "dowidar-7e981",
                storageBucket: "dowidar-7e981.appspot.com",
                messagingSenderId: "583156775225",
                appId: "1:583156775225:android:8d6464b077e996aef790e8",
              ));
    FirebaseService._firebaseMessaging = FirebaseMessaging.instance;
    await FirebaseService.initializeLocalNotifications();
    await FCMProvider.onMessage();
  }

  static Future<String?> getDeviceToken() async => await FirebaseMessaging.instance.getToken();

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initializeLocalNotifications() async {
    const InitializationSettings initSettings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"), iOS: DarwinInitializationSettings());

    /// on did receive notification response = for when app is opened via notification while in foreground on android
    await FirebaseService._localNotificationsPlugin
        .initialize(initSettings, onDidReceiveNotificationResponse: FCMProvider.handleOnTapNotification);

    /// need this for ios foregournd notification
    await FirebaseService.firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static NotificationDetails platformChannelSpecifics = const NotificationDetails(

    android: AndroidNotificationDetails(

      "New Order",
      "New Order",
      priority: Priority.high,
      importance: Importance.high,
    ),
  );

  // for receiving message when app is in background or foreground
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        // if this is available when Platform.isIOS, you'll receive the notification twice
        localNotification(message);
      }
    });
  }

  static localNotification(message) async {
    await FirebaseService._localNotificationsPlugin.show(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      FirebaseService.platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }
}

class FCMProvider with ChangeNotifier {
  static BuildContext? _context;

  static void setContext(BuildContext context) => FCMProvider._context = context;

  /// when app is in the foreground
  // static Future<void> onTapNotification(NotificationResponse? response) async {
  //   if (FCMProvider._context == null || response?.payload == null) return;
  //   final Json _data = FCMProvider.convertPayload(response!.payload!);
  //   if (_data.containsKey(...)){
  //     await Navigator.of(FCMProvider._context!).push(...);
  //   }
  // }
  //
  static convertPayload(String payload) {
    final String _payload = payload.substring(1, payload.length - 1);
    List<String> _split = [];
    _payload.split(",")..forEach((String s) => _split.addAll(s.split(":")));
    Map<String, dynamic> _mapped = {};
    for (int i = 0; i < _split.length; i++) {
      if (i % 2 == 1) _mapped.addAll({_split[i - 1].trim().toString(): _split[i].trim()});
    }
    return _mapped;
  }

  static Future<void> handleOnTapNotification(NotificationResponse? response) async {
    // BannerNotificationPayload notificationPayload =
    // BannerNotificationPayload.fromRawJson(response!.payload![0]);
    if (FCMProvider._context == null || response!.payload == null) return;
    print("Notification Payload: ${response.payload}");

    final Map<String, dynamic> _data = json.decode(response.payload!.substring(10, response.payload!.length - 1));
    print("Payload data: $_data");
    BannerNotificationPayload notificationPayload = BannerNotificationPayload.fromJson(_data);
    cm_HandleDeepLink()
        .handleDeepLink(context: _context, deeplink: notificationPayload.type!, payLoad: notificationPayload.id);
  }

  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // if (FCMProvider._refreshNotifications != null) await FCMProvider._refreshNotifications!(true);
      // if this is available when Platform.isIOS, you'll receive the notification twice
      if (Platform.isAndroid) {
        await FirebaseService._localNotificationsPlugin.show(
          message.hashCode,
          message.notification!.title,
          message.notification!.body,
          FirebaseService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  Future<void> setupInteractedMessage(context) async {
    _context = context;
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      print("Initial message payload:${initialMessage.data}");
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification payload:${message.data["payload"]}");
      _handleOnTapNotification(message);
    });
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    FirebaseService.localNotification(message);
  }
}

class BannerNotificationPayload {
  int? id;
  String? type;
  DiscountData? data;

  BannerNotificationPayload({
    this.id,
    this.type,
    this.data,
  });

  factory BannerNotificationPayload.fromRawJson(String str) {
    return BannerNotificationPayload.fromJson(json.decode(str));
  }

  String toRawJson() => json.encode(toJson());

  factory BannerNotificationPayload.fromJson(Map<String, dynamic> json) => BannerNotificationPayload(
        id: (json["id"] is String) ? int.parse(json['id']) : json['id'],
        type: json["type"],
        data: json['data'] != null ? DiscountData.fromJson(json['data'] as Map<String, dynamic>) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        'data': data?.toJson(),
      };
}

class DiscountData {
  int? id;
  String? title;

  DiscountData({
    this.id,
    this.title,
  });

  factory DiscountData.fromJson(Map<String, dynamic> json) {
    return DiscountData(
      title: json['title'] ?? null,
      id: json['id'] != null
          ? json['id'] is String
              ? int.parse(json['id'])
              : json['id']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'title': title,
    };
    return data;
  }
}
