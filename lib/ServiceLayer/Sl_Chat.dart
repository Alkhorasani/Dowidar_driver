import 'dart:convert';
import 'package:dowidardriver/ClassModules/Urls/ApiUrls.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/MVVM/Model/ModDriverStatus/ModDriverStatus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ClassModules/HttpCalls/HttpCalls.dart';
import '../MVVM/Model/ModDriverStatus/ParaModel.dart';
import '../MVVM/Model/ModGetAllOrders/ModGetAllOrders.dart';
import '../MVVM/Model/ModNewOrder/ModNewOrders.dart';
import '../MVVM/Model/ModNewOrder/ParaModel.dart';
import '../MVVM/Model/ModOrderStatus/ModOrderStatus.dart';
import '../MVVM/Model/ModOrderStatus/ParaModel.dart';
import '../MVVM/Model/ModUserLogin/ModUserLogin.dart';
import '../MVVM/Model/ModUserLogin/PeraModel.dart';

class Sl_Chat {


  Future sendChatMessage(Map<String, String> fields, List<String>? files, String token) async {
    try {
      final response = await HttpCalls().postMultipart(ApiUrls.chatmsg, fields, ['attachment[]'] , [files ?? []], token: token);
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e, stack) {
      throw Exception('Failed to fetch data: $e $stack');
    }
  }
// Your other methods can remain the same.
}
