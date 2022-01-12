import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:otomasyon/view/kermes/Models/KermesProductListModel.dart';
import 'package:otomasyon/view/kermes/Models/KermesTableListModel.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';

import 'OrderCreateModel.dart';


class OrderProductList extends StatefulWidget {


  @override
  _OrderProductListState createState() => _OrderProductListState();
}

class _OrderProductListState extends State<OrderProductList> {

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
    var productData="";
    print(_selectedItems.length);
    for(int i=0;i<_selectedItems.length;i++){
      if(i != _selectedItems.length-1){
        productData = productData+'''{
        "id": ${_selectedItems[i].id.toString()},
        "product_name":"${utf8.decode(_selectedItems[i].productName.toString().runes.toList())}",
        "product_category": {
          "category_name": "${utf8.decode(_selectedItems[i].productCategory.categoryName.toString().runes.toList())}",
          "cat_information": "${_selectedItems[i].productCategory.catInformation.toString()}"
        },
        "product_price": "${_selectedItems[i].productPrice.toString()}",
        "can_Order": ${true},
        "stock": ${true}
        },''';
      }else{
        productData = productData+'''{
        "id": ${_selectedItems[i].id.toString()},
        "product_name":"${utf8.decode(_selectedItems[i].productName.toString().runes.toList())}",
        "product_category": {
          "category_name": "${utf8.decode(_selectedItems[i].productCategory.categoryName.toString().runes.toList())}",
          "cat_information": "${_selectedItems[i].productCategory.catInformation.toString()}"
        },
        "product_price": "${_selectedItems[i].productPrice.toString()}",
        "can_Order": ${true},
        "stock": ${true}
        }''';
      }

    }
    print(productData);
    var finalData = '''{
  "table_number": [
    {
      "area_name": {
        "area_number": 
      },
      "table_number": ""
    }
  ],
  "payment_method": {
    "payment_method": "string"
  },
  "products": [
    $productData
    
  ],
  "total_amount": "${totalAmount.toString()}",
  "isHaveVoucher": ${false},
  "isOrderComplete": ${false}
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
      "Authorization": "Token 8e1e25cabda9405833a97df6f55ff56a0b3ae602",
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
    counterProduct[index] = "0";
    for (final product in _selectedItems) {
      list[index] == product
          ? counterProduct[index] =
          (int.parse(counterProduct[index]) + 1).toString()
          : "";
    }
    totalAmount = 0;
    for(final product in _selectedItems){
      totalAmount +=double.parse(product.productPrice);
    }
    print(_selectedItems);
  }

  void removeProduct(int index) {
    counterProduct[index] = "0";
    for (final product in _selectedItems) {
      list[index] == product
          ? counterProduct[index] =
          (int.parse(counterProduct[index]) + 1).toString()
          : "";
    }
    totalAmount = 0;
    for(final product in _selectedItems){
      totalAmount +=double.parse(product.productPrice);
    }
    print(_selectedItems);
  }
}
