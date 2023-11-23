import 'dart:convert';
import 'package:dowidardriver/ClassModules/Urls/ApiUrls.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/Model/ModDriverStatus/ModDriverStatus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ClassModules/HttpCalls/HttpCalls.dart';
import '../MVVM/Model/ModDriverStatus/ParaModel.dart';
import '../MVVM/Model/ModDriverStatus/ParamModelStatus.dart';


class Sl_DriverStatus {
  Future<bool> fnc_driverStatus() async {
    try {

      ParametrizedDriverStatusModel lParametrizedDriverLocationModel = ParametrizedDriverStatusModel(
          id: cmGlobalVariables.pbDriberID ,status: cmGlobalVariables.pBDriverStatus  );

      String lJsonString = json.encode(lParametrizedDriverLocationModel.toJson());
      List<int> lUtfContent = utf8.encode(lJsonString);
      String dynamicUrl = ApiUrls.driverStatus;
      final lResponse = await HttpCalls().Fnc_HttpWeb(dynamicUrl, lUtfContent);

      if (lResponse.statusCode == 200) {
       // print(lResponse.body);
        return true;
      } else {
        return false;}
    } catch (e) {
      print(e.toString());
      throw Exception("An error occurred");
    }
  }

// Your other methods can remain the same.
}
