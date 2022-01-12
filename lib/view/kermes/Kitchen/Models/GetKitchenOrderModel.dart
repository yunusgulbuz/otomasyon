// To parse this JSON data, do
//
//     final getKitchenOrderModel = getKitchenOrderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetKitchenOrderModel getKitchenOrderModelFromJson(String str) => GetKitchenOrderModel.fromJson(json.decode(str));

String getKitchenOrderModelToJson(GetKitchenOrderModel data) => json.encode(data.toJson());

class GetKitchenOrderModel {
  GetKitchenOrderModel({
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

  factory GetKitchenOrderModel.fromJson(Map<String, dynamic> json) => GetKitchenOrderModel(
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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

class TableNumber {
  TableNumber({
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

  factory TableNumber.fromJson(Map<String, dynamic> json) => TableNumber(
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
