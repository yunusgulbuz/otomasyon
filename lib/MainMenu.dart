import 'package:flutter/material.dart';
import 'package:otomasyon/view/authenticate/login/Models/UsersModel.dart';
import 'package:otomasyon/view/authenticate/user/UserProfile.dart';
import 'package:otomasyon/view/kermes/Kasa/KasaTables.dart';
import 'package:otomasyon/view/kermes/Kasa/KermesPesinOrderComplete.dart';
import 'package:otomasyon/view/kermes/Order/OrderTables.dart';
import 'package:otomasyon/view/kermes/Products/KermesProductList.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MainMenu());

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,debugShowCheckedModeBanner: false,
      home: MyStatefulWidget(

      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool userStyle = false;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    KermesProductList(),
    OrderTables(),
    KasaTables(),
    KermesPesinOrderComplete(),
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    userStyleControl();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(userStyle == false){
      return Scaffold(
      body:
      Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Ürün Listesi',
            backgroundColor: Colors.brown,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Sipariş',
            backgroundColor: Colors.red,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
    }
    else{
      return Scaffold(
        body:
        Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'Ürün Listesi',
              backgroundColor: Colors.brown,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Sipariş',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ad_units_sharp),
              label: 'Kasa',
              backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined),
              label: 'Peşin',
              backgroundColor: Colors.black38,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      );
    }
  }

  void userStyleControl() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getInt('userStyleId') == 4 ? userStyle = true : userStyle = false;
    print("user id :"+sharedPreferences.getInt('userStyleId').toString());
    setState(() {

    });
  }
}
