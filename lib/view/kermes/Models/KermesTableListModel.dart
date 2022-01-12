// To parse this JSON data, do
//
//     final kermesTableListModel = kermesTableListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<KermesTableListModel> kermesTableListModelFromJson(String str) => List<KermesTableListModel>.from(json.decode(str).map((x) => KermesTableListModel.fromJson(x)));

String kermesTableListModelToJson(List<KermesTableListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KermesTableListModel {
  KermesTableListModel({
    required this.id,
    required this.areaName,
    required this.tableNumber,
    required this.tableInformation,
    required this.isEmpty,
  });

  int id;
  AreaName areaName;
  String tableNumber;
  String tableInformation;
  bool isEmpty;

  factory KermesTableListModel.fromJson(Map<String, dynamic> json) => KermesTableListModel(
    id: json["id"],
    areaName: AreaName.fromJson(json["area_name"]),
    tableNumber: json["table_number"],
    tableInformation: json["table_information"],
    isEmpty: json["isEmpty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "area_name": areaName.toJson(),
    "table_number": tableNumber,
    "table_information": tableInformation,
    "isEmpty": isEmpty,
  };
}

class AreaName {
  AreaName({
    required this.id,
    required this.areaNumber,
    required this.areaName,
  });

  int id;
  int areaNumber;
  String areaName;

  factory AreaName.fromJson(Map<String, dynamic> json) => AreaName(
    id: json["id"],
    areaNumber: json["area_number"],
    areaName: json["area_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "area_number": areaNumber,
    "area_name": areaName,
  };
}
