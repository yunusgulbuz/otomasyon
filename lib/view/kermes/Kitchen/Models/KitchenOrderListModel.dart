// To parse this JSON data, do
//
//     final kitchenOrderListModel = kitchenOrderListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<KitchenOrderListModel> kitchenOrderListModelFromJson(String str) => List<KitchenOrderListModel>.from(json.decode(str).map((x) => KitchenOrderListModel.fromJson(x)));

String kitchenOrderListModelToJson(List<KitchenOrderListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KitchenOrderListModel {
  KitchenOrderListModel({
    required this.id,
    required this.tableNumber,
    required this.products,
    required this.totalAmount,
    required this.isHaveVoucher,
    required this.isOrderComplete,
  });

  int id;
  List<TableNumber> tableNumber;
  List<Product> products;
  String totalAmount;
  bool isHaveVoucher;
  bool isOrderComplete;

  factory KitchenOrderListModel.fromJson(Map<String, dynamic> json) => KitchenOrderListModel(
    id: json["id"],
    tableNumber: List<TableNumber>.from(json["table_number"].map((x) => TableNumber.fromJson(x))),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    totalAmount: json["total_amount"],
    isHaveVoucher: json["isHaveVoucher"],
    isOrderComplete: json["isOrderComplete"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "table_number": List<dynamic>.from(tableNumber.map((x) => x.toJson())),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "total_amount": totalAmount,
    "isHaveVoucher": isHaveVoucher,
    "isOrderComplete": isOrderComplete,
  };
}

class Product {
  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productDiscount,
    required this.canOrder,
    required this.stock,
    required this.productCategory,
  });

  int id;
  String productName;
  String productPrice;
  String productDiscount;
  bool canOrder;
  bool stock;
  int productCategory;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productDiscount: json["product_discount"],
    canOrder: json["can_Order"] == null ? false : json["can_Order"],
    stock: json["stock"],
    productCategory: json["product_category"] == null ? 0 : json["product_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "product_price": productPrice,
    "product_discount": productDiscount,
    "can_Order": canOrder == null ? null : canOrder,
    "stock": stock,
    "product_category": productCategory == null ? null : productCategory,
  };
}

class TableNumber {
  TableNumber({
    required this.id,
    required this.tableNumber,
    required this.tableInformation,
    required this.isEmpty,
    required this.tableCreatedDate,
    required this.isPast,
    required this.areaName,
  });

  int id;
  String tableNumber;
  String tableInformation;
  bool isEmpty;
  DateTime tableCreatedDate;
  bool isPast;
  int areaName;

  factory TableNumber.fromJson(Map<String, dynamic> json) => TableNumber(
    id: json["id"],
    tableNumber: json["table_number"],
    tableInformation: json["table_information"],
    isEmpty: json["isEmpty"],
    tableCreatedDate: DateTime.parse(json["table_created_date"]),
    isPast: json["isPast"],
    areaName: json["area_name"] == null ? 1 : json["area_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "table_number": tableNumber,
    "table_information": tableInformation,
    "isEmpty": isEmpty,
    "table_created_date": tableCreatedDate.toIso8601String(),
    "isPast": isPast,
    "area_name": areaName == null ? "" : areaName,
  };
}
