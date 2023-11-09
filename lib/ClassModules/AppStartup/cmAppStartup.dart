import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

import '../cmGlobalVariables/cmGlobalVariables.dart';

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
}
