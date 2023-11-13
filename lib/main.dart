import 'package:dowidardriver/ClassModules/AppStartup/cmAppStartup.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/Model/ModDriverStatus/ModDriverStatus.dart';
import 'package:dowidardriver/ServiceLayer/Sl_DriverLocation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
import 'package:easy_localization/easy_localization.dart';


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

        await fnc_UpdateDriverLocation();
        print("service called");
      }
      catch (e, stack) {
        throw Exception([e, stack]);
        // You can add additional error handling here if needed.
      }
    }
    return Future.value(true);
  });
}

Future<bool> fnc_UpdateDriverLocation() async {
  try {
    ModDriverLocation l_ModDriverLocation = await Sl_DriverLocation().fnc_driverLoction();

    if (l_ModDriverLocation != null) {
      print("Called");
      return true;
    } else {
      print("failed");
      return false;
    }
  } catch (e) {
    print("Error in fnc_GetAllOrders: $e");
    return false; // You can handle the error as needed
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();

  // Initialize any other required variables or services here.

  final sharedPreferences = await SharedPreferences.getInstance();
  final l_driverID = sharedPreferences.getString('l_driverID');

  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp(
          initialRoute: l_driverID != null && l_driverID.isNotEmpty
              ? AppRoutes.vwCommonLayout
              : AppRoutes.initialRoute,
        ),
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
      builder: (BuildContext context, Widget? child)
      {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: GetAppRoutes.Fnc_GetPages(),
          initialRoute: initialRoute,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            useMaterial3: true,
          ),
        );
      }

    );
  }
}
