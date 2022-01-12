// To parse this JSON data, do
//
//     final orderProducts = orderProductsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<OrderProducts> orderProductsFromJson(String str) => List<OrderProducts>.from(json.decode(str).map((x) => OrderProducts.fromJson(x)));

String orderProductsToJson(List<OrderProducts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderProducts {
  OrderProducts({
    required this.id,
    required this.order,
    required this.tableNumber,
    required this.totalAmount,
  });

  int id;
  List<Order> order;
  TableNumber tableNumber;
  String totalAmount;

  factory OrderProducts.fromJson(Map<String, dynamic> json) => OrderProducts(
    id: json["id"],
    order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
    tableNumber: TableNumber.fromJson(json["table_number"]),
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order": List<dynamic>.from(order.map((x) => x.toJson())),
    "table_number": tableNumber.toJson(),
    "total_amount": totalAmount,
  };
}

class Order {
  Order({
    required this.id,
    required this.productCategory,
    required this.productName,
    required this.productPrice,
    required this.productDiscount,
    required this.canOrder,
    required this.stock,
  });

  int id;
  String productCategory;
  String productName;
  String productPrice;
  String productDiscount;
  bool canOrder;
  bool stock;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    productCategory: json["product_category"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productDiscount: json["product_discount"],
    canOrder: json["can_Order"] == null ? false : json["can_Order"],
    stock: json["stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_category": productCategory,
    "product_name": productName,
    "product_price": productPrice,
    "product_discount": productDiscount,
    "can_Order": canOrder == null ? null : canOrder,
    "stock": stock,
  };
}

class TableNumber {
  TableNumber({
    required this.id,
    required this.tableNumber,
    required this.tableInformation,
    required this.isEmpty,
    required this.tableCreatedDate,
    required this.areaName,
  });

  int id;
  int tableNumber;
  String tableInformation;
  bool isEmpty;
  DateTime tableCreatedDate;
  int areaName;

  factory TableNumber.fromJson(Map<String, dynamic> json) => TableNumber(
    id: json["id"],
    tableNumber: json["table_number"],
    tableInformation: json["table_information"],
    isEmpty: json["isEmpty"],
    tableCreatedDate: DateTime.parse(json["table_created_date"]),
    areaName: json["area_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "table_number": tableNumber,
    "table_information": tableInformation,
    "isEmpty": isEmpty,
    "table_created_date": tableCreatedDate.toIso8601String(),
    "area_name": areaName,
  };
}
