import 'dart:convert';
import 'package:dowidardriver/ClassModules/Urls/ApiUrls.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ClassModules/HttpCalls/HttpCalls.dart';
import '../MVVM/Model/ModGetAllOrders/ModGetAllOrders.dart';
import '../MVVM/Model/ModNewOrder/ModNewOrders.dart';
import '../MVVM/Model/ModNewOrder/ParaModel.dart';
import '../MVVM/Model/ModUserLogin/ModUserLogin.dart';
import '../MVVM/Model/ModUserLogin/PeraModel.dart';

class Sl_OrderAccRej {
  Future<ModNewOrders> fnc_OrderAccRej() async {
    try {
      ParametrizedNewOrderModel lParametrizedNewOrderModel =
          ParametrizedNewOrderModel(order_id: cmGlobalVariables.pBOrderId, is_accepted: cmGlobalVariables.pBisAccepted);

      String lJsonString = json.encode(lParametrizedNewOrderModel.toJson());
      List<int> lUtfContent = utf8.encode(lJsonString);
      String dynamicUrl = ApiUrls.newOrders;
      final lResponse = await HttpCalls().Fnc_HttpWeb(dynamicUrl, lUtfContent);

      if (lResponse.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(lResponse.body);
        return ModNewOrders.  fromJson(jsonMap);
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
