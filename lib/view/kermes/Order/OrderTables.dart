import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otomasyon/view/kermes/Order/OrderProductList.dart';
import 'package:otomasyon/view/kermes/Table/CustomDialog.dart';
import 'package:otomasyon/view/kermes/Table/Models/SelectedTableModel.dart';
import 'package:otomasyon/view/kermes/Table/TableCreate.dart';
import 'package:otomasyon/view/kermes/Models/KermesTableListModel.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';
import 'package:http/http.dart' as http;

import 'OrderComplete.dart';


class OrderTables extends StatefulWidget {
  const OrderTables({Key? key}) : super(key: key);

  @override
  _OrderTablesState createState() => _OrderTablesState();
}

class _OrderTablesState extends State<OrderTables> {
   List<KermesTableListModel> ?future;

  @override
  void initState() {
    super.initState();
    getTableList();
  }
  Future getTableList() async {
    final url = Uri.parse(CustomUrl.url + "/kermes/table/");
    final headers = {"Content-type": "application/json","Accept": "application/json",
      "Access-Control-Allow-Origin": "*"};
    final response = await http.get(
      url,headers: headers,
    );
    if (response.statusCode == 200) {
      setState(() {
        future =
        kermesTableListModelFromJson(response.body);
      });
      return future;
    } else if (response.statusCode == 401) {
      // Eğer giriş yapmazsa
      print("yok");
    }
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 2000), (timer) async {
      future = await getTableList();
      setState(() {});

    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int tableGrid = 2;
    print(width);
    if(width>800 && width<1200){
      tableGrid = 4;
    }else if(width>1200 && width<2200){
      tableGrid = 6;
    }
    else if(width>2200){
      tableGrid = 8;
    }
    return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            future == null ?
            Center(child: CircularProgressIndicator()):
            RefreshIndicator(
              onRefresh: getTableList,
              child: Container(
                height: height*(80/100),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: tableGrid,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(future!.length, (index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: Card(
                            color: future![index].isEmpty ? Colors.green[500] : Colors.red[800],
                            elevation: 12,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("- ${future![index].areaName.areaName.toString()} -",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                                  ),
                                  Center(child: Text("M${future![index].tableNumber.toString()}",style: TextStyle(color: Colors.white70),textAlign: TextAlign.center,))
                                ],
                              ),
                            ),
                           // color: future![index].isEmpty ? Colors.green[100] : Colors.red[500],
                          ),
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>OrderComplete(future![index]))).then((value) => null).then((value) => getTableList());
                          },
                        ),
                      )
                    );
                  }),
                ),

              ),
            ),
          ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () => setState(() {
          showDialog(
              context: context,
              builder: (context) {
                return CustomDialog();
              });
          // Navigator.push(context,MaterialPageRoute(builder: (context)=>TableCreate()));

        }),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
   FutureOr onGoBack() {
     setState(() {});
   }
}

