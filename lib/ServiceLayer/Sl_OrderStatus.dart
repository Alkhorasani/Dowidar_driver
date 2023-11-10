import 'dart:convert';
import 'package:dowidardriver/ClassModules/Urls/ApiUrls.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ClassModules/HttpCalls/HttpCalls.dart';
import '../MVVM/Model/ModGetAllOrders/ModGetAllOrders.dart';
import '../MVVM/Model/ModNewOrder/ModNewOrders.dart';
import '../MVVM/Model/ModNewOrder/ParaModel.dart';
import '../MVVM/Model/ModOrderStatus/ModOrderStatus.dart';
import '../MVVM/Model/ModOrderStatus/ParaModel.dart';
import '../MVVM/Model/ModUserLogin/ModUserLogin.dart';
import '../MVVM/Model/ModUserLogin/PeraModel.dart';

class Sl_OrderStatus {
  Future<ModOrderStatus> fnc_OrderStatus() async {
    try {
      ParametrizedOrderStatusModel lParametrizedOrderStatusModel =
      ParametrizedOrderStatusModel(order_id: cmGlobalVariables.pBOrderId, status: cmGlobalVariables.pBOrderStatus);

      String lJsonString = json.encode(lParametrizedOrderStatusModel.toJson());
      List<int> lUtfContent = utf8.encode(lJsonString);
      String dynamicUrl = ApiUrls.orderStatus;
      final lResponse = await HttpCalls().Fnc_HttpWeb(dynamicUrl, lUtfContent);

      if (lResponse.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(lResponse.body);
        return ModOrderStatus.  fromJson(jsonMap);
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
