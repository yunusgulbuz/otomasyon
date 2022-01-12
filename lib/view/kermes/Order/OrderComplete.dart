import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:otomasyon/view/kermes/Kasa/Models/TableAddedProductsModel.dart';
import 'package:otomasyon/view/kermes/Models/KermesProductListModel.dart';
import 'package:otomasyon/view/kermes/Models/KermesTableListModel.dart';
import 'package:otomasyon/view/kermes/Order/Models/OrderCreateModel.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';


class OrderComplete extends StatefulWidget {
  KermesTableListModel table;

  OrderComplete(this.table);

  @override
  State<StatefulWidget> createState() {
    return _OrderCompleteState(this.table);
  }
}

class _OrderCompleteState extends State<OrderComplete> {
  KermesTableListModel table;

  _OrderCompleteState(this.table);

  bool _isLoading = true;
  int orderProductListCount = 0;
  double totalAmount = 0;
  late List<KermesProductListModel> productList;
  late List<TableAddedProductsModel> addedList;
  List<KermesProductListModel> _selectedItems = <KermesProductListModel>[];
  List<KermesProductListModel> _updateSelectItems = <KermesProductListModel>[];
  List<int> counterProduct = <int>[];
  var map = Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(table.isEmpty){
      getProductList("token");
    }else{
      getProductList("token");
      getTableProductList("token");
    }
  }

  Future updateOrder(token, context) async {
    _selectedItems.clear();
    selectedItemAdd();
    addedList.forEach((element) {
      element.soldProduct.forEach((element2) {

      });
    });
    print('selectedProduct: '+_selectedItems.length.toString());
    var productData = "";
    for (int i = 0; i < _selectedItems.length; i++) {
      if (i != _selectedItems.length - 1) {
        productData = productData +
            '''{
                "product_name": {
                    "id": ${_selectedItems[i].id},
                    "product_name": "${utf8.decode(_selectedItems[i].productName.runes.toList())}",
                    "product_category": {
                        "id": ${_selectedItems[i].productCategory.id},
                        "category_name": "${utf8.decode(_selectedItems[i].productCategory.categoryName.runes.toList())}",
                        "cat_information": "${utf8.decode(_selectedItems[i].productCategory.catInformation.runes.toList())}"
                    },
                    "product_price": "${_selectedItems[i].productPrice}",
                    "can_Order": ${_selectedItems[i].canOrder},
                    "stock": ${_selectedItems[i].stock}
                },
                "product_number": ${map[_selectedItems[i].id] != null
                ? map[_selectedItems[i].id]: 1}},''';
      } else {
        productData = productData +
            '''{
                "product_name": {
                    "id": ${_selectedItems[i].id},
                    "product_name": "${utf8.decode(_selectedItems[i].productName.runes.toList())}",
                    "product_category": {
                        "id": ${_selectedItems[i].productCategory.id},
                        "category_name": "${utf8.decode(_selectedItems[i].productCategory.categoryName.runes.toList())}",
                        "cat_information": "${utf8.decode(_selectedItems[i].productCategory.catInformation.runes.toList())}"
                    },
                    "product_price": "${_selectedItems[i].productPrice}",
                    "can_Order": ${_selectedItems[i].canOrder},
                    "stock": ${_selectedItems[i].stock}
                },
                "product_number": ${map[_selectedItems[i].id] != null
                ? map[_selectedItems[i].id]: 1}}''';
      }
    }
    var finalData = '''{
        "table_number": [
            {
                "id": ${table.id},
                "area_name": {
                    "id": ${table.areaName.id}
                },
                "table_number": "${table.tableNumber}",
                "isEmpty": ${false}
            }
        ],
        "payment_method": {
            "id": 7
        },
        "soldProduct": [
    $productData
  ],
        "total_amount": "${totalAmount.toString()}",
        "order_address": "",
        "isHaveVoucher": ${true},
        "isOrderComplete": ${true},
        "OrderProvision": 2
}''';

    final url =
        Uri.parse(CustomUrl.url + "/kermes/order/${addedList.first.id}/");
    final headers = {"Content-type": "application/json"};

    final response = await http.patch(url, headers: headers, body: finalData);

    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Eğer sipariş başarıyla güncellenirse
      Fluttertoast.showToast(
          msg: "Siparişiniz başarıyla kaydedildi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1
      );
      Navigator.pop(context);
    } else{
      Fluttertoast.showToast(
          msg: "Siparişiniz kaydedilemedi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1
      );
    }
  }

  Future createOrder(token, context) async {
    print('selectedItems: '+_selectedItems.length.toString());
    _selectedItems.clear();
    selectedItemAdd();
    var productData = "";
    print(_selectedItems.length);
    for (int i = 0; i < _selectedItems.length; i++) {
      if (i != _selectedItems.length - 1) {
        productData = productData +
            '''{
                "product_name": {
                    "id": ${_selectedItems[i].id},
                    "product_name": "${utf8.decode(_selectedItems[i].productName.runes.toList())}",
                    "product_category": {
                        "id": ${_selectedItems[i].productCategory.id},
                        "category_name": "${utf8.decode(_selectedItems[i].productCategory.categoryName.runes.toList())}",
                        "cat_information": "${utf8.decode(_selectedItems[i].productCategory.catInformation.runes.toList())}"
                    },
                    "product_price": "${_selectedItems[i].productPrice}",
                    "can_Order": ${_selectedItems[i].canOrder},
                    "stock": ${_selectedItems[i].stock}
                },
                "product_number": ${map[_selectedItems[i].id] != null
                ? map[_selectedItems[i].id]: 1}},''';
      } else {
        productData = productData +
            '''{
                "product_name": {
                    "id": ${_selectedItems[i].id},
                    "product_name": "${utf8.decode(_selectedItems[i].productName.runes.toList())}",
                    "product_category": {
                        "id": ${_selectedItems[i].productCategory.id},
                        "category_name": "${utf8.decode(_selectedItems[i].productCategory.categoryName.runes.toList())}",
                        "cat_information": "${utf8.decode(_selectedItems[i].productCategory.catInformation.runes.toList())}"
                    },
                    "product_price": "${_selectedItems[i].productPrice}",
                    "can_Order": ${_selectedItems[i].canOrder},
                    "stock": ${_selectedItems[i].stock}
                },
                "product_number": ${map[_selectedItems[i].id] != null
                ? map[_selectedItems[i].id]: 1}}''';
      }
    }
    var finalData = '''{
        "table_number": [
            {
                "id": ${table.id},
                "area_name": {
                    "id": ${table.areaName.id}
                },
                "table_number": "${table.tableNumber}",
                "isEmpty": ${false}
            }
        ],
        "payment_method": {
            "id": 7
        },
        "soldProduct": [
    $productData
  ],
        "total_amount": "${totalAmount.toString()}",
        "order_address": "",
        "isHaveVoucher": ${false},
        "isOrderComplete": ${true},
        "OrderProvision": 2
}''';
    print(finalData);
    final url = Uri.parse(CustomUrl.url + "/kermes/order/");
    final headers = {"Content-type": "application/json"};
    final response = await http.post(url, headers: headers, body: finalData);

    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Siparişiniz başarıyla kaydedildi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1
      );
    } else{
      Fluttertoast.showToast(
          msg: "Siparişiniz kaydedilemedi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1
      );
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
        print('Çekilen Toplam Ürün Sayısı : '+orderProductListCount.toString());
        productList = result;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
    }
  }

  getTableProductList(token) async {

    final url = Uri.parse(CustomUrl.url + "/kermes/table/${table.tableNumber}/order/");
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      List<TableAddedProductsModel> result =
          tableAddedProductsModelFromJson(response.body);
      addedList = result;
      setState(() {
        addedList.isNotEmpty ? addProducts():"";
      });
    } else {
      // getProductList("token");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text("${table.areaName.areaName} - ${table.tableNumber} Sipariş Ekranı"),
              backgroundColor:  table.isEmpty ? Colors.green:Colors.red
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: height*75/100,
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
                            color: table.isEmpty ? Colors.green[300]:Colors.red[300],
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:width*1.5/3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              utf8.decode(productList[index]
                                                  .productName
                                                  .runes
                                                  .toList()),
                                              style:
                                                  TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              utf8.decode(productList[index]
                                                  .productCategory
                                                  .categoryName
                                                  .runes
                                                  .toList()),
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 8),
                                  child: Text(
                                    map[productList[index].id] != null
                                        ? map[productList[index].id]
                                        .toString()
                                        : "",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            productList[index].productPrice +
                                                "₺",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              removeProduct(
                                                  index);
                                            });
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                    padding:
                        const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Toplam Tutar :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "$totalAmount ₺",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[900]),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                                width: width - 20,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: table.isEmpty ? Colors.green:Colors.red,
                                      ),
                                  onPressed: () {
                                    table.isEmpty
                                        ? createOrder("sadas", context)
                                        : updateOrder("token", context);
                                  },
                                  child: Text(table.isEmpty ? "Siparişi Kaydet":"Siparişi Güncelle"),
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }

  void addProduct(int index) {
    _updateSelectItems.add(productList[index]);
    counterProduct.add(productList[index].id);
    addTotalAmountFunc(productList[index].id);
    print('counterProduct'+counterProduct.length.toString());
    map.clear();
    counterProduct.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });
    print(counterProduct);
  }

  void removeProduct(int index) {
    _updateSelectItems.add(productList[index]);
    counterProduct.remove(productList[index].id);
    deleteTotalAmountFunc(productList[index].id);
    map.clear();
    counterProduct.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });
    print(counterProduct);
  }

  void addProducts() {
    for (int i = 0; i < addedList.last.soldProduct.length; i++) {
      counterProduct.add(addedList.last.soldProduct[i].productName.id);
      addTotalAmountFunc(addedList.last.soldProduct[i].productName.id);
    }
    map.clear();
    counterProduct.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });
    print(counterProduct);
  }

  void selectedItemAdd() {
    for (int i = 0; i < counterProduct.length; i++) {
      productList.forEach((element) {
        if (counterProduct[i] == element.id) {
          _selectedItems.add(element);
          print('girdi');
        }
      });
    }
  }

  double addTotalAmountFunc(int id){
    productList.forEach((element) {
      id == element.id ? totalAmount+=double.parse(element.productPrice):0;
    });
    return totalAmount;
  }
  double deleteTotalAmountFunc(int id){
     productList.forEach((element) {
       if(double.parse(element.productPrice)<totalAmount || double.parse(element.productPrice)==totalAmount) {
         id == element.id
             ? totalAmount -= double.parse(element.productPrice)
             : 0;
       }
     });
    return totalAmount;
  }
}
