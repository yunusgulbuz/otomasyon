import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:otomasyon/view/kermes/Kasa/Models/TableAddedProductsModel.dart';
import 'package:otomasyon/view/kermes/Models/KermesProductListModel.dart';
import 'package:otomasyon/view/kermes/Models/KermesTableListModel.dart';
import 'package:otomasyon/view/kermes/Order/Models/OrderCreateModel.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';

class KasaOrderComplete extends StatefulWidget {
  KermesTableListModel table;

  KasaOrderComplete(this.table);

  @override
  State<StatefulWidget> createState() {
    return _KasaOrderCompleteState(this.table);
  }
}

class _KasaOrderCompleteState extends State<KasaOrderComplete> {
  KermesTableListModel table;
  String barkod = "";
  double finishAmount = 0;
  String finishedIskonto = "0";

  _KasaOrderCompleteState(this.table);

  double deneme = 0;
  bool _isLoading = true;
  int orderProductListCount = 0;
  double totalAmount = 0;
  late List<KermesProductListModel> productList;
  late List<TableAddedProductsModel> addedList;
  List<KermesProductListModel> _selectedItems = <KermesProductListModel>[];
  List<int> counterProduct = <int>[];
  var map = Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(table.isEmpty);
    getProductList("token");
    getTableProductList("token");
  }

  Future updateOrder(token, context,[int paymentMethods=7]) async {

    selectedItemAdd();
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
                "product_number": ${map[_selectedItems[i].id] != null ? map[_selectedItems[i].id] : 1}},''';
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
                "product_number": ${map[_selectedItems[i].id] != null ? map[_selectedItems[i].id] : 1}}''';
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
                "isEmpty": ${true}
            }
        ],
        "payment_method": {
            "id": $paymentMethods
        },
        "soldProduct": [
    $productData
  ],
        "total_amount": "${totalAmount.toString()}",
        "order_address": "",
        "isHaveVoucher": ${true},
        "isOrderComplete": ${false},
        "OrderProvision": 1
}''';

    final url =
        Uri.parse(CustomUrl.url + "/kermes/order/${addedList.first.id}/");
    final headers = {"Content-type": "application/json"};

    final response = await http.patch(url, headers: headers, body: finalData);

    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      // E??er sipari?? ba??ar??yla g??ncellenirse
      Fluttertoast.showToast(
          msg: "Al????veri?? ba??ar??yla kaydedildi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: "Al????veri?? kaydedilemedi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }
  }

  Future createCardOrder(token, context, barkod1) async {
    var finalData = '{"satin_alan":"${barkod1.toString().trim()}","odenecek_miktar":${totalAmount.toInt()}}';
    final url =
        Uri.parse(CustomUrl.url + "market/productSelling/");
    final headers = {"Content-type": "application/json"};

    final response = await http.post(url, headers: headers, body: finalData);

    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      // E??er sipari?? ba??ar??yla g??ncellenirse
      updateOrder("token",context,8);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: "??deme ba??ar??l?? olmad??.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
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
        print(
            '??ekilen Toplam ??r??n Say??s?? : ' + orderProductListCount.toString());
        productList = result;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
    }
  }

  getTableProductList(token) async {
    final url =
        Uri.parse(CustomUrl.url + "/kermes/table/${table.tableNumber}/order/");
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
        addProducts();
      });
    } else {
      // getProductList("token");
    }
    totalAmountFunc();
  }

  @override
  Widget build(BuildContext contextMain) {
    double width = MediaQuery.of(contextMain).size.width;
    double height = MediaQuery.of(contextMain).size.height;
    TextEditingController _iskontoController =
        new TextEditingController(text: "0");
    TextEditingController _bahsisController =
        new TextEditingController(text: "0");
    TextEditingController _iskontoInfController = new TextEditingController();

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nakit Al????veri?? Ekran??"),
                    Text(
                      "$finishAmount ???",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    )
                  ],
                ),
                backgroundColor: Colors.black38),
            body: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (RawKeyEvent event) {
                if (event.runtimeType.toString() == 'RawKeyDownEvent') {
                  barkod += event.data.keyLabel.characters.string;
                  if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                    createCardOrder("token", contextMain, barkod);
                    print(barkod);
                    barkod = "";
                  }
                }
              },
              autofocus: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: height * 70 / 100,
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
                              color: Colors.black38,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
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
                                                  "???",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                removeProduct(index);
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
                      padding: const EdgeInsets.only(
                          bottom: 30, left: 10, right: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: width * 1 / 3,
                                    child: TextFormField(
                                      controller: _bahsisController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Bah??i??',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: width * 1 / 5,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black38,
                                      ),
                                      onPressed: () {
                                        print(_iskontoController.text);
                                        finishAmount = totalAmount -
                                            double.parse(
                                                _iskontoController.text) +
                                            double.parse(
                                                _bahsisController.text);
                                        setState(() {
                                          finishedIskonto =
                                              _iskontoController.text;
                                        });
                                      },
                                      child: Text('Aktar'),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: width * 1 / 3,
                                    child: TextFormField(
                                      controller: _iskontoController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: '??skonto',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                    width: width - 20,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black,
                                      ),
                                      onPressed: () {
                                        showDialog<String>(
                                          context: contextMain,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title:
                                                const Text('Sipari?? Onaylama'),
                                            content: Text(
                                                '$finishAmount??? Nakit Al????veri??i Onayl??yor musunuz?'),
                                            actions: <Widget>[
                                              finishedIskonto != "0"
                                                  ? TextFormField(
                                                      controller:
                                                          _iskontoInfController,
                                                      decoration:
                                                          InputDecoration(
                                                        errorText: iskontoControl(
                                                            _iskontoInfController
                                                                .text),
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            '??skonto sebebi',
                                                      ))
                                                  : Text(""),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, '??ptal'),
                                                child: const Text('??ptal'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, 'Tamam');
                                                  updateOrder('token', contextMain);
                                                },
                                                child: const Text('Tamam'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Text("Al????veri??i Tamamla"),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  String iskontoControl(value) {
    if (value.isEmpty) {
      return "Bu alan bo?? ge??ilemez";
    }
    return "";
  }

  void addProduct(int index) {
    counterProduct.add(productList[index].id);
    addTotalAmountFunc(productList[index].id);
    print('counterProduct ' + counterProduct.length.toString());
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
        }
      });
    }
  }

  double addTotalAmountFunc(int id) {
    productList.forEach((element) {
      id == element.id ? totalAmount += double.parse(element.productPrice) : 0;
    });
    finishAmount = totalAmount;
    return totalAmount;
  }

  double totalAmountFunc() {
    productList.isNotEmpty
        ? productList.forEach((element) {
            for (int i = 0; i < addedList.first.soldProduct.length; i++) {
              addedList.first.soldProduct[i].id == element.id
                  ? totalAmount += double.parse(element.productPrice)
                  : 0;
            }
          })
        : "";
    finishAmount = totalAmount;
    return totalAmount;
  }

  double deleteTotalAmountFunc(int id) {
    productList.forEach((element) {
      if (double.parse(element.productPrice) < totalAmount ||
          double.parse(element.productPrice) == totalAmount) {
        id == element.id
            ? totalAmount -= double.parse(element.productPrice)
            : 0;
      }
    });
    finishAmount = totalAmount;
    return totalAmount;
  }
}
