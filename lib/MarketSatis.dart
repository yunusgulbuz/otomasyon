import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otomasyon/core/constants/ButtonStyles.dart';
import 'package:otomasyon/core/constants/CustomColors.dart';
import 'package:otomasyon/core/constants/TextStyles.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';
import 'package:otomasyon/view/market/Models/UrunListModel.dart';
import 'package:http/http.dart' as http;

class MarketSatis extends StatefulWidget {
  const MarketSatis({Key? key}) : super(key: key);

  @override
  _MarketSatisState createState() => _MarketSatisState();
}

class _MarketSatisState extends State<MarketSatis> {
  int counter = 0;
  late List<UrunListModel> urunList = <UrunListModel>[];
  late List<UrunListModel> secilenUrunList = <UrunListModel>[];
  Uri url = Uri.parse(CustomUrl.url + "api/market/UrunlerList?format=json");
  String barkod = "";
  double satisToplam = 0;

  Future productCreate() async {
    final url = Uri.parse(CustomUrl.url + "api/market/UrunlerList");
    final headers = {"Content-type": "application/json"};


    final json = '{"urun_adi": "Hello2", "barkodu": 1231231232, "alis_fiyati": 1, "satis_fiyati":5,"mevcut_adet":10}';
    final response = await http.post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }
  Future urunlerinTumunuCek() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = urunListModelFromJson(response.body);
        print(result[0].urunAdi);
        if (mounted) {
          setState(() {
            urunList = result;
          });
        }
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    urunlerinTumunuCek();
    productCreate();
  }

  @override
  Widget build(BuildContext context) {
    void callProduct() {
      for (int i = 0; i < urunList.length; i++) {
        if (barkod.trim() == urunList[i].barkodu.toString().trim()) {
          setState(() {
            secilenUrunList.add(urunList[i]);
            counter = secilenUrunList.length;
            satisToplam += urunList[i].satisFiyati;
          });
          barkod = "";
          break;
        } else if (i == urunList.length - 1) {
          barkod = "";
        }
      }
    }

    void urunSil(int index) {
      satisToplam -= secilenUrunList[index].satisFiyati;
      secilenUrunList.removeAt(index);
      counter = secilenUrunList.length;
    }

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event.runtimeType.toString() == 'RawKeyDownEvent') {
          barkod += event.data.keyLabel.characters.string;
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            callProduct();
            print(barkod);
            barkod = "";
          }
        }
      },
      autofocus: true,
      child: Container(
        child: urunList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: CustomColors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, right: 20.0, top: 17.0, bottom: 17.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Toplam',
                                    style: TextStyle(
                                        color: CustomColors.coolGrey,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    '₺ ${satisToplam.toString()}',
                                    style: TextStyle(
                                        color: CustomColors.richBlack,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  productCreate();
                                },
                                child: Text('Tamamla'),
                                style: CustomButtonStyles.palatinateBlueButton,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 28.0, bottom: 10.5),
                    child: Text(
                      'Ürünler',
                      style: TextStyles.coolGreyFont,
                    ),
                  ),
                  secilenUrunList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: counter,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0,
                                    right: 24.0,
                                    top: 6.5,
                                    bottom: 6.5),
                                child: Card(
                                  child: ListTile(
                                    title: Text(secilenUrunList[index].urunAdi),
                                    subtitle: Text(""),
                                    trailing: Wrap(
                                      spacing: 12,
                                      children: [
                                        Text(
                                          secilenUrunList[index]
                                                  .satisFiyati
                                                  .toString() +
                                              '₺',
                                          style:
                                              TextStyles.urunListTileMoneyFont,
                                        ),
                                        GestureDetector(
                                          child: Icon(Icons.delete),
                                          onTap: () {
                                            setState(() {
                                              urunSil(index);
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                    leading: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minHeight: 53.0,
                                          minWidth: 66.0,
                                          maxHeight: 53.0,
                                          maxWidth: 66.0,
                                        ),
                                        child: CircleAvatar(
                                            radius: 2,
                                            backgroundImage: NetworkImage(
                                                'https://images.ofix.com/product-image/Sirma-Dogal-Kaynak-Suyu-Pet-Sise-12-Adet_RI63542FT1MF219072-buyuk.jpg'))),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(child: Text("Listede Ürün Yok")),
                ],
              )
            : Center(child: CircularProgressIndicator()),

      ),
    );
  }
}
