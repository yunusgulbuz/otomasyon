import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:otomasyon/view/kermes/Kasa/Models/TableAddedProductsModel.dart';
import 'package:otomasyon/view/kermes/Models/KermesProductListModel.dart';
import 'package:otomasyon/view/kermes/Models/KermesTableListModel.dart';
import 'package:otomasyon/view/kermes/Order/Models/OrderCreateModel.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';


class KermesProductList extends StatefulWidget {
  const KermesProductList({Key? key}) : super(key: key);
  @override
  _KermesProductListState createState() => _KermesProductListState();
}

class _KermesProductListState extends State<KermesProductList> {

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
    getProductList();
  }

  Future getProductList() async {
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text("Menü"),
              backgroundColor: Colors.brown,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RefreshIndicator(
                    onRefresh: getProductList,
                    child: SizedBox(
                      height: height*100/100,
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
                              color: Colors.brown[300],
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
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
                                                  TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),
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
                                                  color: Colors.white),
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
                  ),
                ],
              ),
            ),
          );
  }

  void addProduct(int index) {
    counterProduct.add(productList[index].id);
    addTotalAmountFunc(productList[index].id);
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
    for (int i = 0; i < addedList.first.soldProduct.length; i++) {
      counterProduct.add(addedList.first.soldProduct[i].productName.id);
      addTotalAmountFunc(addedList.first.soldProduct[i].productName.id);
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
