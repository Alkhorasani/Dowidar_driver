import 'dart:convert';
import 'package:dowidardriver/ClassModules/Urls/ApiUrls.dart';
import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:http/http.dart' as http;

import '../ClassModules/HttpCalls/HttpCalls.dart';
import '../MVVM/Model/ModUserLogin/ModUserLogin.dart';
import '../MVVM/Model/ModUserLogin/PeraModel.dart';

class Sl_UserLogin {
  Future<ModUserData> fnc_Userlogin_apiCall() async {
    // String? countryCode = "+966" + cmGlobalVariables.pbEmail!;

    try {
      ParametrizedLoginModel lParametrizedLoginModel =
          ParametrizedLoginModel(prPhoneno: cmGlobalVariables.pbEmail, pr_Password: cmGlobalVariables.pbPassword);

      String lJsonString = json.encode(lParametrizedLoginModel.toJson());
      List<int> lUtfContent = utf8.encode(lJsonString);
      String dynamicUrl =
          ApiUrls.userLogin + "phone=${cmGlobalVariables.pbEmail}&password=${cmGlobalVariables.pbPassword}";
      final lResponse = await HttpCalls().Fnc_HttpWeb(dynamicUrl, lUtfContent);

      if (lResponse.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(lResponse.body);
        return ModUserData.fromJson(jsonMap);
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
