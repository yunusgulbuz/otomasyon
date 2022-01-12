// To parse this JSON data, do
//
//     final marketUrunListModel = marketUrunListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MarketUrunListModel> marketUrunListModelFromJson(String str) => List<MarketUrunListModel>.from(json.decode(str).map((x) => MarketUrunListModel.fromJson(x)));

String marketUrunListModelToJson(List<MarketUrunListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarketUrunListModel {
  MarketUrunListModel({
    required this.id,
    required this.urunAdi,
    required this.barkodu,
    required this.mevcutAdet,
    required this.alisFiyati,
    required this.satisFiyati,
    required this.image,
    required this.status,
    required this.draft,
    required this.createAt,
    required this.updateAt,
    required this.slug,
    required this.kategori,
  });

  int id;
  String urunAdi;
  int barkodu;
  int mevcutAdet;
  String alisFiyati;
  String satisFiyati;
  dynamic image;
  String status;
  bool draft;
  DateTime createAt;
  DateTime updateAt;
  String slug;
  dynamic kategori;

  factory MarketUrunListModel.fromJson(Map<String, dynamic> json) => MarketUrunListModel(
    id: json["id"],
    urunAdi: json["urun_adi"],
    barkodu: json["barkodu"],
    mevcutAdet: json["mevcut_adet"],
    alisFiyati: json["alis_fiyati"],
    satisFiyati: json["satis_fiyati"],
    image: json["image"],
    status: json["status"],
    draft: json["draft"],
    createAt: DateTime.parse(json["create_at"]),
    updateAt: DateTime.parse(json["update_at"]),
    slug: json["slug"],
    kategori: json["kategori"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "urun_adi": urunAdi,
    "barkodu": barkodu,
    "mevcut_adet": mevcutAdet,
    "alis_fiyati": alisFiyati,
    "satis_fiyati": satisFiyati,
    "image": image,
    "status": status,
    "draft": draft,
    "create_at": createAt.toIso8601String(),
    "update_at": updateAt.toIso8601String(),
    "slug": slug,
    "kategori": kategori,
  };
}
