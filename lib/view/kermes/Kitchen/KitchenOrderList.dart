import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';
import 'package:http/http.dart' as http;
import 'Models/KitchenOrderListModel.dart';

class KitchenOrderList extends StatefulWidget {
  const KitchenOrderList({Key? key}) : super(key: key);

  @override
  _KitchenOrderListState createState() => _KitchenOrderListState();
}

class _KitchenOrderListState extends State<KitchenOrderList> {
  bool _isLoading = true;
  int orderProductListCount = 0;
  late List<KitchenOrderListModel> list;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpTimedFetch();
  }

  Future getProductList(token) async {
    final url = Uri.parse(CustomUrl.url + "/kermes/order/");
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token 8e1e25cabda9405833a97df6f55ff56a0b3ae602",
      "Access-Control-Allow-Origin": "*"
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      List<KitchenOrderListModel> result =
          kitchenOrderListModelFromJson(response.body);
      setState(() {
        _isLoading = false;
        orderProductListCount = result.length;
        list = result;
      });
      voucherControl();
    } else {
      setState(() {
        _isLoading = true;
      });
    }
  }

  Future voucherControl() async {

    for (int i = 0; i < list.length; i++) {

      if (list[i].isHaveVoucher == false) {
        final url =
        Uri.parse(CustomUrl.url + "/kermes/order/${list[i].id}/");
        final headers = {
          "Content-type": "application/json",
          "Accept": "application/json",
        };
        final json =
              '{"isHaveVoucher": "${true}"}';
        final response = await http.patch(
          url,
          headers: headers,
          body: json,
        );
        if (response.statusCode == 200) {

        }
        else{
          print("${response.statusCode} Sisteme kayıt başarısız oldu");
        }
      }
    }
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 2000), (timer) async {
      print('dasdas');
      list = await getProductList("ds");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: orderProductListCount,
            itemBuilder: (BuildContext context, int index1) {
              return Container(
                height: 50,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Card(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: getData(list[index1].products),
                          ),
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          list[index1].tableNumber.isNotEmpty
                              ? list[index1].tableNumber.first.id.toString()
                              : "Masa Yok",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                )),
              );
            });
  }

  List<InlineSpan> getData(List mylist) {
    List<InlineSpan> temp = [];

    for (int i = 0; i < mylist.length; i++) {
      print(mylist[i].productName);
      temp.add(
        TextSpan(
          text: mylist[i].productName + " - ",
          style: TextStyle(
            height: 1.0,
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return temp;
  }
}
