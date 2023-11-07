import 'dart:convert';
import 'package:dowidardriver/ClassModules/Urls/ApiUrls.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:http/http.dart' as http;

import '../ClassModules/HttpCalls/HttpCalls.dart';
import '../MVVM/Model/ModGetAllOrders/ModGetAllOrders.dart';
import '../MVVM/Model/ModUserLogin/ModUserLogin.dart';
import '../MVVM/Model/ModUserLogin/PeraModel.dart';

class Sl_GetAllOrders {
  Future<ModGetAllOrders> fnc_GetAllorders_apiCall() async {
    try {
      // Fetch the authorization token (e.g., from cmGlobalVariables)
      String? authToken = cmGlobalVariables.Pb_ModDriverLocalData?.accessToken;

      String dynamicUrl =   ApiUrls.getAllOrders +"driver_id=${cmGlobalVariables.Pb_ModDriverLocalData?.id}&per_page=20";

      final lResponse = await HttpCalls().fnc_GetHttpRequests(dynamicUrl, authToken);

      if (lResponse.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(lResponse.body);
        return ModGetAllOrders.fromJson(jsonMap);
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
