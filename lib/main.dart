import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MVVM/ViewModel/Vm_Home/Vm_Home.dart';
import 'Routing/AppRoutes.dart';
import 'Routing/GetRoutes.dart';

import 'package:permission_handler/permission_handler.dart';





Future<Position?> getUserLocation() async {

  try {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position; // This Position object contains latitude and longitude.
  } catch (e) {
    print('Error getting user location: $e');
    return null;
  }
}


Future<bool> FncPermissions() async {
  // Request app notification permission
  final notificationStatus = await Permission.notification.request();

  if (notificationStatus.isGranted) {
    // Request user location permission
    final locationStatus = await Permission.location.request();

    Position? userLocation = await getUserLocation();

    if (userLocation != null) {
      cmGlobalVariables.pBUserLatitude = userLocation.latitude;
      cmGlobalVariables.pBUserLongitude = userLocation.longitude;

      // You can now use 'latitude' and 'longitude' in your app.
    } else {
      // Handle the case where user location couldn't be determined.
      print('User location not available.');
    }

    if (locationStatus.isGranted) {
      return true;
    }

    if (locationStatus.isDenied || locationStatus.isRestricted) {
      // Show a pop-up to request the location permission
      await Permission.location.request();
    }
  }

  if (notificationStatus.isDenied || notificationStatus.isRestricted) {
    // Show a pop-up to request the app notification permission
    await Permission.notification.request();
  }

  return false;
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized.

  FncPermissions();
  final userLocation = await getUserLocation();
  print(userLocation);
  print(userLocation);


  final sharedPreferences = await SharedPreferences.getInstance();
  final l_driverID = sharedPreferences.getString('l_driverID');
  runApp(MyApp(initialRoute: l_driverID != null && l_driverID.isNotEmpty ? AppRoutes.vwCommonLayout : AppRoutes.initialRoute));

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
