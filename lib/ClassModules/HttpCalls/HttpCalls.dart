import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Urls/ApiUrls.dart';

class HttpCalls {

  Future<http.Response> Fnc_HttpWebToken(String lControllerUrl) async {
    Uri lUri = Uri.parse(ApiUrls.Pb_BaseAPIURL + lControllerUrl);
    final lResponse = await http.get(lUri);
    return lResponse;
  }

  Future<http.Response> Fnc_HttpWeb(String lControllerUrl, List<int> lUtfContent) async {

    final l_SharedPreferences = await SharedPreferences.getInstance();
    final accessToken = l_SharedPreferences.getString('l_token') ?? '';

    Uri lUri = Uri.parse(ApiUrls.Pb_BaseAPIURL + lControllerUrl);
    Map<String, String> lStringContect = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    };
    final lResponse = await http.post(lUri, headers: lStringContect, body: lUtfContent);
    return lResponse;
  }

  Future<http.Response> fnc_GetHttpRequests(String? lControllerUrl, String? authToken) async {
    Uri lUri = Uri.parse(ApiUrls.Pb_BaseAPIURL + lControllerUrl!);
    Map<String, String> lStringContent = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
    };

    final lResponse = await http.get(lUri, headers: lStringContent);
    return lResponse;
  }

}