import 'dart:io';

import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:huawei_push/huawei_push.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:dowidardriver/ClassModules/Urls/ApiUrls.dart';
import 'package:http/http.dart' as http;

import '../ClassModules/HttpCalls/HttpCalls.dart';
import '../MVVM/Model/ModFirebasemodel/ModRequestNotifications.dart';

class Sl_FirebaseNotifications {
  Future FncaddUserDevice() async {
    try {
      final l_SharedPreferences = await SharedPreferences.getInstance();
      final accessToken = l_SharedPreferences.getString('l_token') ?? '';

      // Check if we have a valid access token
      if (accessToken.isEmpty) {
        throw Exception("No access token available for device token update");
      }

      // Check if we have a firebase token
      if (cmGlobalVariables.pBFirebaseNotificationToken == null || 
          cmGlobalVariables.pBFirebaseNotificationToken!.isEmpty) {
        throw Exception("Firebase notification token is not available");
      }

      // Get device information with fallbacks
      String deviceName = l_SharedPreferences.getString('deviceName') ?? '';
      String os = l_SharedPreferences.getString('os') ?? '';
      String os_version = l_SharedPreferences.getString('osVersion') ?? '';

      // If device info is not available, provide platform-specific defaults
      if (deviceName.isEmpty || os.isEmpty || os_version.isEmpty) {
        print('Device information not found in SharedPreferences, using platform defaults');
        if (Platform.isAndroid) {
          deviceName = deviceName.isEmpty ? 'Android Device' : deviceName;
          os = os.isEmpty ? 'Android' : os;
          os_version = os_version.isEmpty ? 'Unknown' : os_version;
        } else if (Platform.isIOS) {
          deviceName = deviceName.isEmpty ? 'iOS Device' : deviceName;
          os = os.isEmpty ? 'iOS' : os;
          os_version = os_version.isEmpty ? 'Unknown' : os_version;
        } else {
          deviceName = deviceName.isEmpty ? 'Unknown Device' : deviceName;
          os = os.isEmpty ? 'Unknown' : os;
          os_version = os_version.isEmpty ? 'Unknown' : os_version;
        }
      }

      ModRequestNotifications l_ModRequestNotifications = ModRequestNotifications(
          deviceName: deviceName, 
          device_token: cmGlobalVariables.pBFirebaseNotificationToken, 
          os: os, 
          os_version: os_version);

      String lJsonString = json.encode(l_ModRequestNotifications.toJson());
      List<int> lUtfContent = utf8.encode(lJsonString);
      String dynamicUrl = ApiUrls.updateDeviceToken;
      
      print('Updating device token with URL: ${ApiUrls.Pb_BaseAPIURL + dynamicUrl}');
      print('Request body: $lJsonString');
      print('Access token: ${accessToken.substring(0, 20)}...');
      
      final lResponse = await HttpCalls().Fnc_HttpWeb(dynamicUrl, lUtfContent);

      print('Device token update response status: ${lResponse.statusCode}');
      print('Device token update response body: ${lResponse.body}');

      if (lResponse.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(lResponse.body);
        print('Device token updated successfully');
        return jsonMap;
      } else {
        throw Exception("Failed to update device token. Status: ${lResponse.statusCode}, Body: ${lResponse.body}");
      }
    } catch (e, stack) {
      print('Error in FncaddUserDevice: $e');
      print('Stack trace: $stack');
      throw Exception("Device token update failed: $e");
    }
  }
}
