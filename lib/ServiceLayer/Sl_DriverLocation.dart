import 'dart:convert';
import 'package:dowidardriver/ClassModules/Urls/ApiUrls.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/Model/ModDriverStatus/ModDriverStatus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ClassModules/HttpCalls/HttpCalls.dart';
import '../MVVM/Model/ModDriverStatus/ParaModel.dart';


class Sl_DriverLocation {
  Future<ModDriverLocation> fnc_driverLoction() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      ParametrizedDriverLocationModel lParametrizedDriverLocationModel = ParametrizedDriverLocationModel(
          latitude: position.latitude.toString(), longitude: position.longitude.toString());

      String lJsonString = json.encode(lParametrizedDriverLocationModel.toJson());
      List<int> lUtfContent = utf8.encode(lJsonString);
      String dynamicUrl = ApiUrls.driverLocation;
      final lResponse = await HttpCalls().Fnc_HttpWeb(dynamicUrl, lUtfContent);

      if (lResponse.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(lResponse.body);
        return ModDriverLocation.fromJson(jsonMap);
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("An error occurred");
    }
  }

// Your other methods can remain the same.
}
