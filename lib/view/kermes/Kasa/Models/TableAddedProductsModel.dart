// To parse this JSON data, do
//
//     final tableAddedProductsModel = tableAddedProductsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TableAddedProductsModel> tableAddedProductsModelFromJson(String str) => List<TableAddedProductsModel>.from(json.decode(str).map((x) => TableAddedProductsModel.fromJson(x)));

String tableAddedProductsModelToJson(List<TableAddedProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableAddedProductsModel {
  TableAddedProductsModel({
    required this.id,
    required this.tableNumber,
    required this.paymentMethod,
    required this.soldProduct,
    required this.totalAmount,
    required this.orderAddress,
    required this.isHaveVoucher,
    required this.isOrderComplete,
    required this.orderProvision,
    required this.tableCreatedDate,
  });

  int id;
  List<TableNumber> tableNumber;
  PaymentMethod paymentMethod;
  List<SoldProduct> soldProduct;
  String totalAmount;
  String orderAddress;
  bool isHaveVoucher;
  bool isOrderComplete;
  int orderProvision;
  DateTime tableCreatedDate;

  factory TableAddedProductsModel.fromJson(Map<String, dynamic> json) => TableAddedProductsModel(
    id: json["id"],
    tableNumber: List<TableNumber>.from(json["table_number"].map((x) => TableNumber.fromJson(x))),
    paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
    soldProduct: List<SoldProduct>.from(json["soldProduct"].map((x) => SoldProduct.fromJson(x))),
    totalAmount: json["total_amount"],
    orderAddress: json["order_address"],
    isHaveVoucher: json["isHaveVoucher"],
    isOrderComplete: json["isOrderComplete"],
    orderProvision: json["OrderProvision"],
    tableCreatedDate: DateTime.parse(json["table_created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "table_number": List<dynamic>.from(tableNumber.map((x) => x.toJson())),
    "payment_method": paymentMethod.toJson(),
    "soldProduct": List<dynamic>.from(soldProduct.map((x) => x.toJson())),
    "total_amount": totalAmount,
    "order_address": orderAddress,
    "isHaveVoucher": isHaveVoucher,
    "isOrderComplete": isOrderComplete,
    "OrderProvision": orderProvision,
    "table_created_date": tableCreatedDate.toIso8601String(),
  };
}

class PaymentMethod {
  PaymentMethod({
    required this.id,
    required this.paymentMethod,
    required this.tableCreatedDate,
  });

  int id;
  String paymentMethod;
  DateTime tableCreatedDate;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    paymentMethod: json["payment_method"],
    tableCreatedDate: DateTime.parse(json["table_created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payment_method": paymentMethod,
    "table_created_date": tableCreatedDate.toIso8601String(),
  };
}

class SoldProduct {
  SoldProduct({
    required this.id,
    required this.productName,
    required this.productNumber,
  });

  int id;
  ProductName productName;
  int productNumber;

  factory SoldProduct.fromJson(Map<String, dynamic> json) => SoldProduct(
    id: json["id"],
    productName: ProductName.fromJson(json["product_name"]),
    productNumber: json["product_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName.toJson(),
    "product_number": productNumber,
  };
}

class ProductName {
  ProductName({
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

  factory ProductName.fromJson(Map<String, dynamic> json) => ProductName(
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
