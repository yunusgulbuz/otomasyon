// To parse this JSON data, do
//
//     final selectedTableModel = selectedTableModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SelectedTableModel selectedTableModelFromJson(String str) => SelectedTableModel.fromJson(json.decode(str));

String selectedTableModelToJson(SelectedTableModel data) => json.encode(data.toJson());

class SelectedTableModel {
  SelectedTableModel({
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

  factory SelectedTableModel.fromJson(Map<String, dynamic> json) => SelectedTableModel(
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
