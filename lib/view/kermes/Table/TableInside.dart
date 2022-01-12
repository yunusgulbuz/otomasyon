import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otomasyon/core/constants/CustomColors.dart';
import 'package:otomasyon/view/authenticate/user/UserProfile.dart';
import 'package:otomasyon/view/kermes/Models/ProductListModel.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';
import 'package:http/http.dart' as http;

import 'Models/OrderProducts.dart';

class TableInside extends StatefulWidget {


  @override
  _TableInsideState createState() => _TableInsideState();
}
int productListCount=0;


class _TableInsideState extends State<TableInside> {
  List<OrderProducts?>? orderProductResult;
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductList("aasd",1);
  }
   getProductList(token,tableId) async {
    final url = Uri.parse(CustomUrl.url + "/kermes/tableDetail/$tableId");
    final headers = {"Content-type": "application/json","Accept": "application/json",
      "Access-Control-Allow-Origin": "*"};
    final response = await http.get(
      url,headers: headers,
    );
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      List<OrderProducts> result=orderProductsFromJson(response.body);
      setState(() {
        productListCount = result.first.order.length;
        orderProductResult = result;
        _isLoading = false; // sayfaya ulaşıldı
      });
      return result;
    } else{
      // Eğer ürün çekilemezse
      setState(() {
        _isLoading = true; // sayfaya ulaşılamadı
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

      return _isLoading ? Center(child: CircularProgressIndicator()) : Scaffold(
        backgroundColor: Colors.green.withOpacity(0.8),
        body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.05, top: width * 0.1),
                  child: Text("Ürünler", style: TextStyle(
                      color: Colors.white, //Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.08
                  ),),

                ),

                urunList(width, height),
                tutarHesaplama(width),
                tamamlaButon(),
              ],
            )

        ),

      );
  }

  Center tamamlaButon() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(onPressed: () {},
            child: Text("Alışverişi Tamamla"),
            style: ElevatedButton.styleFrom(
              primary: CustomColors.green, // background
              onPrimary: Colors.white, // foreground
            ),),
        ),
      ),
    );
  }
  Widget tutarHesaplama(double width) {
    return
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "Toplam Tutar",
              style: TextStyle(
                color: Colors.white, fontSize: 16,),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.05),
            child: Text(orderProductResult!.first!.totalAmount,
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.08,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],);
  }
  Padding urunList(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.03, top: width * 0.08),
      child: SizedBox(
        width: width,
        height: height * 0.50,
        child: ListView.builder(
          itemCount: productListCount,
          itemBuilder: (context, index) {
            List<Order> order = orderProductResult!.first!.order;
            if (order[index] == order.last) {
              return TimeLineItem(mov: order[index],
                colorItem: CustomColors.green,
                isLast: true,);
            } else {
              return TimeLineItem(mov: order[index],
                colorItem: CustomColors.green,
                isLast: false,);
            }
          },
        ),
      ),
    );
  }
}


class TimeLineItem extends StatelessWidget {
  final Order mov;
  final bool isLast;
  final Color colorItem;

  const TimeLineItem({required this.mov,required this.isLast, required this.colorItem});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return
      productListCount != 0 ?
      Container(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: <Widget>[
                  Container(
                    width: width * 0.03,
                    height: height * 0.015,
                    decoration: BoxDecoration(
                        color: colorItem,//Colors.red[900],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: width * 0.02, bottom: width * 0.02),
                    child: Container(
                      width: width * 0.004,
                      height: isLast != true? height * 0.05 : height * 0.03,
                      decoration: BoxDecoration(
                        color:  Colors.grey[850] ,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: Text(
                      utf8.decode(mov.productName.runes.toList()),
                      style: TextStyle(
                        color: Colors.white, fontSize: width * 0.05,),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: width * 0.05, top: width * 0.02),
                    child: Text(
                      utf8.decode(mov.productCategory.runes.toList()),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: width * 0.034,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.05),
            child: Text(mov.productPrice,


              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    ):
      CircularProgressIndicator();
  }
}
