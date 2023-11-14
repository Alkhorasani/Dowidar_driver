import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../MVVM/Model/ModDriverStatus/ModDriverStatus.dart';
import '../../ServiceLayer/Sl_DriverLocation.dart';

class cmAppStartup {
  Future<bool> FncPermissions() async {
    // Request app notification permission
    final notificationStatus = await Permission.notification.request();

    if (notificationStatus.isGranted) {
      // Request user location permission
      final locationStatus = await Permission.location.request();

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

  Future<void> fncGetDeviceInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        sharedPreferences.setString('deviceName', androidInfo.model);
        sharedPreferences.setString('deviceID', androidInfo.id);
        sharedPreferences.setString('os', 'Android');
        sharedPreferences.setString('osVersion', androidInfo.version.release);
        print(androidInfo.id);
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        sharedPreferences.setString('deviceName', iosInfo.name);
        final deviceID = iosInfo.identifierForVendor ?? ''; // If identifierForVendor is null, assign an empty string

        sharedPreferences.setString('deviceID', deviceID);
        sharedPreferences.setString('os', 'iOS');
        sharedPreferences.setString('osVersion', iosInfo.systemVersion);
        print(deviceID);

      } else {
        throw Exception('Unsupported platform');
      }
    } on PlatformException {
      print("Error obtaining device information");
    }
  }
}
