import 'package:flutter/material.dart';
import 'package:otomasyon/MarketSatis.dart';
import 'package:otomasyon/core/constants/CustomColors.dart';
import 'package:otomasyon/view/authenticate/login/login.dart';
import 'package:otomasyon/view/kermes/Kasa/KasaTables.dart';
import 'package:otomasyon/view/kermes/Kitchen/KitchenOrderList.dart';
import 'package:otomasyon/view/kermes/Order/OrderProductList.dart';
import 'package:otomasyon/view/kermes/Products/KermesProductList.dart';
import 'package:otomasyon/view/kermes/Table/TableCreate.dart';
import 'package:otomasyon/view/kermes/Table/TableInside.dart';
import 'package:otomasyon/view/kermes/Table/Tables.dart';

import 'MainMenu.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: CustomColors.coolGrey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(),

    );
  }
}