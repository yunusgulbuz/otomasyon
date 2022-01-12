// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProductListModel> productListModelFromJson(String str) => List<ProductListModel>.from(json.decode(str).map((x) => ProductListModel.fromJson(x)));

String productListModelToJson(List<ProductListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductListModel {
  ProductListModel({
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

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    id: json["id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productDiscount: json["product_discount"],
    canOrder: json["can_Order"],
    stock: json["stock"],
    productCategory: json["product_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "product_price": productPrice,
    "product_discount": productDiscount,
    "can_Order": canOrder,
    "stock": stock,
    "product_category": productCategory,
  };
}
