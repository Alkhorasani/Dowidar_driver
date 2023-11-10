import 'package:dowidardriver/ClassModules/AppStartup/cmAppStartup.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/Model/ModDriverStatus/ModDriverStatus.dart';
import 'package:dowidardriver/ServiceLayer/Sl_DriverLocation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

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

        await fnc_UpdateDriverLocation();
        print("service called");
      } catch (e, stack) {
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
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized.

  cmGlobalVariables.pBisSwitch_onOff = false;
  cmAppStartup().FncPermissions();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  Workmanager().registerPeriodicTask(
    'get_user_location', // Task name matches the one in callbackDispatcher
    'get_user_location_key', // Unique key for this task
    initialDelay: Duration(seconds: 1), // Initial delay before the first execution
    frequency: Duration(seconds: 10), // Repeat every 10 seconds
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  final l_driverID = sharedPreferences.getString('l_driverID');
  runApp(MyApp(
      initialRoute: l_driverID != null && l_driverID.isNotEmpty ? AppRoutes.vwCommonLayout : AppRoutes.initialRoute));

  runApp(MyApp(
    // initialRoute: AppRoutes.initialRoute,
    initialRoute: AppRoutes.initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Get.put(Vm_Home());
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
}
