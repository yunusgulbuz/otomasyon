import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:otomasyon/view/kermes/Models/KermesProductListModel.dart';
import 'package:otomasyon/view/kermes/Models/KermesTableListModel.dart';
import 'package:otomasyon/view/kermes/Table/Models/SelectedTableModel.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';

import 'Models/OrderCreateModel.dart';

class OrderProductList extends StatefulWidget {
  KermesTableListModel table;
  OrderProductList(this.table);
  @override
  State<StatefulWidget> createState() {
    return _OrderProductListState(this.table);
  }
}

class _OrderProductListState extends State<OrderProductList> {
  KermesTableListModel table;
  _OrderProductListState(this.table);
  bool _isLoading = true;
  int orderProductListCount = 0;
  double totalAmount = 0;
  late List<KermesProductListModel> list;
  List<KermesProductListModel> _selectedItems = <KermesProductListModel>[];
  List<String> counterProduct = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductList("token");
  }

  Future createOrder(token,context) async {
    // final table = ModalRoute.of(context)!.settings.arguments as KermesTableListModel;
    List<String> products = <String>[];
    var productData="";
    print(_selectedItems.length);
    for(int i=0;i<_selectedItems.length;i++){
        if(i != _selectedItems.length-1){
          productData = productData+'''{
                "product_name": {
                    "id": ${_selectedItems[i].id},
                    "product_name": "${_selectedItems[i].productName}",
                    "product_category": {
                        "id": ${_selectedItems[i].productCategory.id},
                        "category_name": "${_selectedItems[i].productCategory.categoryName}",
                        "cat_information": "${_selectedItems[i].productCategory.catInformation}"
                    },
                    "product_price": "${_selectedItems[i].productPrice}",
                    "can_Order": ${_selectedItems[i].canOrder},
                    "stock": ${_selectedItems[i].stock}
                },
                "product_number": ${counterProduct[_selectedItems[i].id]}},''';
        }else{
          productData = productData+'''{
                "product_name": {
                    "id": ${_selectedItems[i].id},
                    "product_name": "${_selectedItems[i].productName}",
                    "product_category": {
                        "id": ${_selectedItems[i].productCategory.id},
                        "category_name": "${_selectedItems[i].productCategory.categoryName}",
                        "cat_information": "${_selectedItems[i].productCategory.catInformation}"
                    },
                    "product_price": "${_selectedItems[i].productPrice}",
                    "can_Order": ${_selectedItems[i].canOrder},
                    "stock": ${_selectedItems[i].stock}
                },
                "product_number": ${counterProduct[_selectedItems[i].id]}}''';
        }
    }
    var finalData = '''{
        "table_number": [
            {
                "id": ${table.id},
                "area_name": {
                    "id": ${table.areaName.id},
                },
                "table_number": "${table.tableNumber}",
                "isEmpty": ${false}
            }
        ],
        "payment_method": {
            "id": 7,
        },
        "soldProduct": [
    $productData
  ],
        "total_amount": "${totalAmount.toString()}",
        "order_address": "",
        "isHaveVoucher": ${false},
        "isOrderComplete": ${false},
        "table_created_date": "2022-01-07T14:42:55Z"
}''';
    print(finalData);
    final url = Uri.parse(CustomUrl.url + "/kermes/order/");
    final headers = {"Content-type": "application/json"};

    final response = await http.post(url, headers: headers, body: finalData);

    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      // Eğer giriş yaparsa
      var result = orderCreateModelFromJson(response.body);
      // urunList(result.token);
    } else if (response.statusCode == 401) {
      // Eğer giriş yapmazsa
      var result = orderCreateModelFromJson(response.body);
    }
  }

  getProductList(token) async {
    final url = Uri.parse(CustomUrl.url + "/kermes/product/");
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      List<KermesProductListModel> result =
          kermesProductListModelFromJson(response.body);
      setState(() {
        _isLoading = false;
        orderProductListCount = result.length;
        print(orderProductListCount);
        list = result;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
      appBar: AppBar(
        title: Text("Ürün seçimi"),
      ),
          body: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 500,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: orderProductListCount,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              addProduct(index);
                            });
                          },
                          child: Container(
                            height: 50,
                            color: Colors.green[600],
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8),
                                            child: Text(
                                              counterProduct.isEmpty
                                                  ? ""
                                                  : counterProduct[index],
                                              style: TextStyle(
                                                  color: Colors.yellowAccent,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            utf8.decode(
                                                list[index].productName.runes.toList()),
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            utf8.decode(list[index]
                                                .productCategory
                                                .categoryName
                                                .runes
                                                .toList()),
                                            style: TextStyle(color: Colors.white70),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(list[index].productPrice + "₺",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedItems.remove(list[index]);
                                              removeProduct(index);
                                            });
                                          },
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.white70,
                                                  ),
                                                ],
                                              )),
                                        )
                                      ],
                                    )),
                              ],
                            )),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30,left: 10,right: 10),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: [
                      Text("Toplam Tutar :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      Text("$totalAmount ₺",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.orange),)
                    ],
                    ),
                    Row(children: [
                      SizedBox(width:width-20,height:50,child: ElevatedButton(onPressed: (){createOrder("sadas",context);}, child: Text("Siparişi Kaydet"),))
                    ],)

                  ],),
                )
              ],
            ),
          ),
        );
  }

  void addProduct(int index) {
    _selectedItems.add(list[index]);
    for (int i = 0; i < list.length; i++) {
      counterProduct.add("0");
    }
    counterProduct[list[index].id] = "0";
    for (final product in _selectedItems) {
      list[index] == product
          ? counterProduct[list[index].id] =
              (int.parse(counterProduct[list[index].id]) + 1).toString()
          : "";
    }
    totalAmount = 0;
    for(final product in _selectedItems){
      totalAmount +=double.parse(product.productPrice);
    }
    print(_selectedItems);
  }

  void removeProduct(int index) {
    counterProduct[list[index].id] = "0";
    for (final product in _selectedItems) {
      list[index] == product
          ? counterProduct[list[index].id] =
              (int.parse(counterProduct[list[index].id]) + 1).toString()
          : "";
    }
    totalAmount = 0;
    for(final product in _selectedItems){
      totalAmount +=double.parse(product.productPrice);
    }
    print(_selectedItems);
  }
}
