import 'dart:convert';
import 'dart:io';

import 'package:dowidardriver/ClassModules/cmHandleDeepLink/cm_HandleDeepLink.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../MVVM/ViewModel/Vm_CommonLayout/Vm_CommonLayout.dart';

BuildContext? _context;

_handleOnTapNotification(RemoteMessage message) {
  String type = message.data['type'];
  String id = message.data['order_id'];
  (message.notification!.body!);

  cm_HandleDeepLink().handleDeepLink(
      context: _context,
      deeplink: type,
      payLoad: id);
}

class FirebaseService {
  static FirebaseMessaging? _firebaseMessaging;

  static FirebaseMessaging get firebaseMessaging =>
      FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

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

  static localNotification(RemoteMessage message) async {
    final Vm_CommonLayout l_Vm_CommonLayout = Get.put(Vm_CommonLayout());

    l_Vm_CommonLayout.fnc_GetAllOrders();
    await FirebaseService._localNotificationsPlugin.show(message.hashCode, message.notification!.title,
        message.notification!.body, FirebaseService.platformChannelSpecifics,
        payload: jsonEncode(message.data));
  }


  // for receiving message when app is in background or foreground
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        // if this is available when Platform.isIOS, you'll receive the notification twice
        localNotification(message);
      }
    });
  }

}

class FCMProvider  {
  static void setContext(BuildContext context) => _context = context;

  static Future<void> handleOnTapNotification(NotificationResponse? response) async {
    if (_context == null || response!.payload == null) return;
    Map<String, dynamic> payload = jsonDecode(response.payload!);
    NotificationPayload payloadData = NotificationPayload.fromJson(payload);
      cm_HandleDeepLink() .handleDeepLink(context: _context, deeplink: payloadData.type ?? '', payLoad: payloadData.orderId);
  }

  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // if (FCMProvider._refreshNotifications != null) await FCMProvider._refreshNotifications!(true);
      // if this is available when Platform.isIOS, you'll receive the notification twice
      if (Platform.isAndroid) {
        FirebaseService.localNotification(message);
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

NotificationPayload notificationPayloadFromJson(String str) => NotificationPayload.fromJson(json.decode(str));

String notificationPayloadToJson(NotificationPayload data) => json.encode(data.toJson());

class NotificationPayload {
  String? type;
  String? orderId;

  NotificationPayload({
    this.type,
    this.orderId,
  });

  factory NotificationPayload.fromJson(Map<String, dynamic> json) => NotificationPayload(
    type: json["type"],
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "order_id": orderId,
  };
}
