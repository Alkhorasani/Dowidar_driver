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
      final deviceName = l_SharedPreferences.getString('deviceName') ?? '';
      final os = l_SharedPreferences.getString('os') ?? '';
      final os_version = l_SharedPreferences.getString('osVersion') ?? '';

      ModRequestNotifications l_ModRequestNotifications = ModRequestNotifications(
          deviceName: deviceName, device_token: cmGlobalVariables.pBFirebaseNotificationToken, os: os, os_version: os_version);

      String lJsonString = json.encode(l_ModRequestNotifications.toJson());
      List<int> lUtfContent = utf8.encode(lJsonString);
      String dynamicUrl = ApiUrls.updateDeviceToken;
      final lResponse = await HttpCalls().Fnc_HttpWeb(dynamicUrl, lUtfContent);

      if (lResponse.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(lResponse.body);
        print('Notification called');

        return jsonDecode(lResponse.body);
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e, stack) {
      throw Exception([e, stack]);
    }
  }
}
