// To parse this JSON data, do
//
//     final urunListModel = urunListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UrunListModel> urunListModelFromJson(String str) => List<UrunListModel>.from(json.decode(str).map((x) => UrunListModel.fromJson(x)));

String urunListModelToJson(List<UrunListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UrunListModel {
  UrunListModel({
    required this.urunAdi,
    required this.mevcutAdet,
    required this.alisFiyati,
    required this.satisFiyati,
    required this.barkodu,
  });

  String urunAdi;
  dynamic mevcutAdet;
  dynamic alisFiyati;
  dynamic satisFiyati;
  int barkodu;

  factory UrunListModel.fromJson(Map<String, dynamic> json) => UrunListModel(
    urunAdi: json["urun_adi"],
    mevcutAdet: json["mevcut_adet"],
    alisFiyati: json["alis_fiyati"],
    satisFiyati: json["satis_fiyati"],
    barkodu: json["barkodu"],
  );

  Map<String, dynamic> toJson() => {
    "urun_adi": urunAdi,
    "mevcut_adet": mevcutAdet,
    "alis_fiyati": alisFiyati,
    "satis_fiyati": satisFiyati,
    "barkodu": barkodu,
  };
}
