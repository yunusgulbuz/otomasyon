// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UsersModel> usersModelFromJson(String str) => List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
  UsersModel({
    required this.id,
    required this.username,
    required this.email,
    required this.userBarkod,
    required this.userStyle,
  });

  int id;
  String username;
  String email;
  UserBarkod userBarkod;
  UserStyle userStyle;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
    id: json["id"],
    username: json["username"] ?? "",
    email: json["email"],
    userBarkod: UserBarkod.fromJson(json["UserBarkod"] ),
    userStyle: UserStyle.fromJson(json["userStyle"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "UserBarkod": userBarkod.toJson(),
    "userStyle": userStyle.toJson(),
  };
}

class UserBarkod {
  UserBarkod({
    required this.id,
    required this.cardBarkod,
    required this.cardBakiye,
    required this.toplamHarcanan,
    required this.barkodStyle,
  });

  int id;
  String cardBarkod;
  String cardBakiye;
  String toplamHarcanan;
  BarkodStyle barkodStyle;

  factory UserBarkod.fromJson(Map<String, dynamic> json) => UserBarkod(
    id: json["id"],
    cardBarkod: json["cardBarkod"],
    cardBakiye: json["card_bakiye"],
    toplamHarcanan: json["toplam_Harcanan"],
    barkodStyle: BarkodStyle.fromJson(json["BarkodStyle"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cardBarkod": cardBarkod,
    "card_bakiye": cardBakiye,
    "toplam_Harcanan": toplamHarcanan,
    "BarkodStyle": barkodStyle.toJson(),
  };
}

class BarkodStyle {
  BarkodStyle({
    required this.id,
    required this.styleName,
    required this.styleNameInf,
  });

  int id;
  String styleName;
  String styleNameInf;

  factory BarkodStyle.fromJson(Map<String, dynamic> json) => BarkodStyle(
    id: json["id"],
    styleName: json["StyleName"],
    styleNameInf: json["StyleNameInf"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "StyleName": styleName,
    "StyleNameInf": styleNameInf,
  };
}

class UserStyle {
  UserStyle({
    required this.id,
    required this.userStyle,
    required this.userStyleInf,
  });

  int id;
  String userStyle;
  String userStyleInf;

  factory UserStyle.fromJson(Map<String, dynamic> json) => UserStyle(
    id: json["id"],
    userStyle: json["userStyle"],
    userStyleInf: json["userStyleInf"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userStyle": userStyle,
    "userStyleInf": userStyleInf,
  };
}
