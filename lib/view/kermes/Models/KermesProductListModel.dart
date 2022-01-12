// To parse this JSON data, do
//
//     final kermesProductListModel = kermesProductListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<KermesProductListModel> kermesProductListModelFromJson(String str) => List<KermesProductListModel>.from(json.decode(str).map((x) => KermesProductListModel.fromJson(x)));

String kermesProductListModelToJson(List<KermesProductListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KermesProductListModel {
  KermesProductListModel({
    required this.id,
    required this.productName,
    required this.productCategory,
    required this.productPrice,
    required this.canOrder,
    required this.stock,
  });

  int id;
  String productName;
  ProductCategory productCategory;
  String productPrice;
  bool canOrder;
  bool stock;

  factory KermesProductListModel.fromJson(Map<String, dynamic> json) => KermesProductListModel(
    id: json["id"],
    productName: json["product_name"],
    productCategory: ProductCategory.fromJson(json["product_category"]),
    productPrice: json["product_price"],
    canOrder: json["can_Order"],
    stock: json["stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "product_category": productCategory.toJson(),
    "product_price": productPrice,
    "can_Order": canOrder,
    "stock": stock,
  };
}

class ProductCategory {
  ProductCategory({
    required this.id,
    required this.categoryName,
    required this.catInformation,
  });

  int id;
  String categoryName;
  String catInformation;

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["id"],
    categoryName: json["category_name"],
    catInformation: json["cat_information"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "cat_information": catInformation,
  };
}
