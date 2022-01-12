// To parse this JSON data, do
//
//     final getSuccessDetailOrderModel = getSuccessDetailOrderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetSuccessDetailOrderModel getSuccessDetailOrderModelFromJson(String str) => GetSuccessDetailOrderModel.fromJson(json.decode(str));

String getSuccessDetailOrderModelToJson(GetSuccessDetailOrderModel data) => json.encode(data.toJson());

class GetSuccessDetailOrderModel {
  GetSuccessDetailOrderModel({
    required this.detail,
  });

  String detail;

  factory GetSuccessDetailOrderModel.fromJson(Map<String, dynamic> json) => GetSuccessDetailOrderModel(
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
  };
}
