// To parse this JSON data, do
//
//     final superAdminModel = superAdminModelFromJson(jsonString);

import 'dart:convert';

import 'package:dowidardriver/MVVM/Model/ModUserLogin/ModUserLogin.dart';


SuperAdminModel superAdminModelFromJson(String str) => SuperAdminModel.fromJson(json.decode(str));

String superAdminModelToJson(SuperAdminModel data) => json.encode(data.toJson());

class SuperAdminModel {
  String? message;
  List<ModUserData>? data;

  SuperAdminModel({
    this.message,
    this.data,
  });

  factory SuperAdminModel.fromJson(Map<String, dynamic> json) => SuperAdminModel(
    message: json["message"],
    data: json["data"] == null ? [] : List<ModUserData>.from(json["data"]!.map((x) => ModUserData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}