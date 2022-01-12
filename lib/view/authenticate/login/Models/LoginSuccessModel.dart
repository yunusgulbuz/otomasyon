// To parse this JSON data, do
//
//     final loginSuccessModel = loginSuccessModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginSuccessModel loginSuccessModelFromJson(String str) => LoginSuccessModel.fromJson(json.decode(str));

String loginSuccessModelToJson(LoginSuccessModel data) => json.encode(data.toJson());

class LoginSuccessModel {
  LoginSuccessModel({
    required this.token,
  });

  String token;

  factory LoginSuccessModel.fromJson(Map<String, dynamic> json) => LoginSuccessModel(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
