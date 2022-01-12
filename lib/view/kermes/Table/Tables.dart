import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otomasyon/view/kermes/Order/OrderProductList.dart';
import 'package:otomasyon/view/kermes/Table/CustomDialog.dart';
import 'package:otomasyon/view/kermes/Table/Models/SelectedTableModel.dart';
import 'package:otomasyon/view/kermes/Table/TableCreate.dart';
import 'package:otomasyon/view/kermes/Models/KermesTableListModel.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';
import 'package:http/http.dart' as http;

class Tables extends StatefulWidget {
  const Tables({Key? key}) : super(key: key);

  @override
  _TablesState createState() => _TablesState();
}

class _TablesState extends State<Tables> {
   List<KermesTableListModel> ?future;

  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
  }

  Future getTableList() async {
    final url = Uri.parse(CustomUrl.url + "/kermes/table/");
    final headers = {"Content-type": "application/json","Accept": "application/json",
      "Access-Control-Allow-Origin": "*"};
    final response = await http.get(
      url,headers: headers,
    );
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      List<KermesTableListModel> result =
          kermesTableListModelFromJson(response.body);

      return result;
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              future == null ?
              Center(child: CircularProgressIndicator()):
              Container(
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
                            Navigator.of(context).push(MaterialPageRoute(builder:(context)=>OrderProductList(future![index])));
                          },
                        ),
                      )
                    );
                  }),
                ),

              ),
            ],
      ),
        ),
    );
  }

}

