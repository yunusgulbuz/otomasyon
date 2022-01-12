// To parse this JSON data, do
//
//     final orderCreateModel = orderCreateModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderCreateModel orderCreateModelFromJson(String str) => OrderCreateModel.fromJson(json.decode(str));

String orderCreateModelToJson(OrderCreateModel data) => json.encode(data.toJson());

class OrderCreateModel {
  OrderCreateModel({
    required this.tableNumber,
    required this.paymentMethod,
    required this.products,
    required this.totalAmount,
    required this.orderAddress,
    required this.isHaveVoucher,
    required this.isOrderComplete,
  });

  List<TableNumber> tableNumber;
  PaymentMethod paymentMethod;
  List<Product> products;
  String totalAmount;
  String orderAddress;
  bool isHaveVoucher;
  bool isOrderComplete;

  factory OrderCreateModel.fromJson(Map<String, dynamic> json) => OrderCreateModel(
    tableNumber: List<TableNumber>.from(json["table_number"].map((x) => TableNumber.fromJson(x))),
    paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
    products:json["products"] != null ? new List<Product>.from( json["products"].map((x) => Product.fromJson(x))) : <Product>[],
    totalAmount: json["total_amount"],
    orderAddress: json["order_address"],
    isHaveVoucher: json["isHaveVoucher"],
    isOrderComplete: json["isOrderComplete"],
  );

  Map<String, dynamic> toJson() => {
    "table_number": List<dynamic>.from(tableNumber.map((x) => x.toJson())),
    "payment_method": paymentMethod.toJson(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "total_amount": totalAmount,
    "order_address": orderAddress,
    "isHaveVoucher": isHaveVoucher,
    "isOrderComplete": isOrderComplete,
  };
}

class PaymentMethod {
  PaymentMethod({
    required this.paymentMethod,
  });

  String paymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    paymentMethod: json["payment_method"],
  );

  Map<String, dynamic> toJson() => {
    "payment_method": paymentMethod,
  };
}

class Product {
  Product({
    required this.productName,
    required this.productCategory,
    required this.productPrice,
    required this.canOrder,
    required this.stock,
  });

  String productName;
  ProductCategory productCategory;
  String productPrice;
  bool canOrder;
  bool stock;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productName: json["product_name"],
    productCategory: ProductCategory.fromJson(json["product_category"]),
    productPrice: json["product_price"],
    canOrder: json["can_Order"],
    stock: json["stock"],
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "product_category": productCategory.toJson(),
    "product_price": productPrice,
    "can_Order": canOrder,
    "stock": stock,
  };
}

class ProductCategory {
  ProductCategory({
    required this.categoryName,
    required this.catInformation,
  });

  String categoryName;
  String catInformation;

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    categoryName: json["category_name"],
    catInformation: json["cat_information"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "cat_information": catInformation,
  };
}

class TableNumber {
  TableNumber({
    required this.areaName,
    required this.tableNumber,
    required this.tableInformation,
    required this.isEmpty,
  });

  AreaName areaName;
  String tableNumber;
  String tableInformation;
  bool isEmpty;

  factory TableNumber.fromJson(Map<String, dynamic> json) => TableNumber(
    areaName: AreaName.fromJson(json["area_name"]),
    tableNumber: json["table_number"],
    tableInformation: json["table_information"],
    isEmpty: json["isEmpty"],
  );

  Map<String, dynamic> toJson() => {
    "area_name": areaName.toJson(),
    "table_number": tableNumber,
    "table_information": tableInformation,
    "isEmpty": isEmpty,
  };
}

class AreaName {
  AreaName({
    required this.areaNumber,
    required this.areaName,
  });

  int areaNumber;
  String areaName;

  factory AreaName.fromJson(Map<String, dynamic> json) => AreaName(
    areaNumber: json["area_number"],
    areaName: json["area_name"],
  );

  Map<String, dynamic> toJson() => {
    "area_number": areaNumber,
    "area_name": areaName,
  };
}
