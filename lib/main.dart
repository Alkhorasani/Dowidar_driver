import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dowidardriver/ClassModules/AppStartup/cmAppStartup.dart';
import 'package:dowidardriver/ClassModules/cmFirebaseServices/cmFirebaseServices.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/ClassModules/cm_LanguageController/cm_LanguageController.dart';
import 'package:dowidardriver/MVVM/Model/ModDriverStatus/ModDriverStatus.dart';
import 'package:dowidardriver/ServiceLayer/Sl_DriverLocation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'ChatModule/provider/chat_provider.dart';
import 'MVVM/ViewModel/Vm_Home/Vm_Home.dart';
import 'Routing/AppRoutes.dart';
import 'Routing/GetRoutes.dart';

import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  print("here i am");
  Workmanager().executeTask((task, inputData) async {
    if (task == "get_user_location") {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

        cmGlobalVariables.pBUserLatitude = position.latitude;
        cmGlobalVariables.pBUserLongitude = position.longitude;

        print("Latitude: ${cmGlobalVariables.pBUserLatitude}");
        print("Longitude: ${cmGlobalVariables.pBUserLongitude}");

        await Future.delayed(Duration(seconds: 2000));

        await cmAppStartup().fnc_UpdateDriverLocation();
        print("service called");
      } catch (e, stack) {
        throw Exception([e, stack]);
        // You can add additional error handling here if needed.
      }
    }
    return Future.value(true);
  });
}

Future<void> onBackgroundMsg(RemoteMessage msg) async {
  print("sas");
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

  print("Handling a background message: ${msg.messageId}");
  FirebaseService.localNotification(msg);

}

Future<void> _initializeNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cmAppStartup().FncPermissions();

  await Firebase.initializeApp();
  await FirebaseService.initializeFirebase();
  _initializeNotifications();
  FirebaseMessaging.onBackgroundMessage(onBackgroundMsg);

  cmAppStartup().fncGetDeviceInfo();

  Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    isInDebugMode: true,
  );
  Workmanager().registerPeriodicTask(
    "get_user_location_periodic_task",
    "get_user_location", // Specify the name of the task
    frequency: Duration(minutes: 10), // Set the frequency of the task
  );

  // Initialize any other required variables or services here.

  final sharedPreferences = await SharedPreferences.getInstance();
  final l_driverID = sharedPreferences.getString('l_driverID');

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  if (androidPlugin != null) {
    androidPlugin.requestNotificationsPermission();
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MyApp(
        initialRoute: l_driverID != null && l_driverID.isNotEmpty ? AppRoutes.vwCommonLayout : AppRoutes.initialRoute,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Get.put(Vm_Home());
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            translations: cm_LanguageController(),
            locale: Locale('en', 'US'),
            fallbackLocale: Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            getPages: GetAppRoutes.Fnc_GetPages(),
            initialRoute: initialRoute,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
              useMaterial3: true,
            ),
          );
        });
  }
}
