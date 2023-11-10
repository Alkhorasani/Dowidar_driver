import 'dart:convert';
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


  Future<dynamic> postMultipart(String endpoint,
      Map<String, String> fields, List<String> filesKey, List<List<String>> files,
      {String? token}) async {
    final request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.headers.addAll(token != null
        ? {
      'Accept': 'application/json; charset=UTF-8',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    }
        : <String, String>{
      'Accept': 'application/json; charset=UTF-8',
      'Content-Type': 'application/json; charset=UTF-8'
    });
    // Add fields to the request
    print(fields);
    request.fields.addAll(fields);

    // Add files to the request
    for (int i = 0; i < filesKey.length; i++){
      for (int j = 0; j < files[i].length; j++) {
        var file = files[i][j];
        if (file.isNotEmpty && file != '') {
          request.files.add(await http.MultipartFile.fromPath(filesKey[i], file));
        }
      }
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("Response of Mutipart request ${response.body}");
      return response;
    } else {
      throw Exception('${jsonDecode(response.body)}');
    }
  }




}