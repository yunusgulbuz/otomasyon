import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otomasyon/core/constants/CustomColors.dart';
import 'package:otomasyon/view/authenticate/user/UserProfile.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';
import 'package:http/http.dart' as http;

class TableCreate extends StatefulWidget {
  @override
  _TableCreateState createState() => _TableCreateState();
}

tableCreate(token, tableNo, tableDescription, tableArea, tableEmpty) async {
  print(int.parse(tableArea) + 5);
  final url = Uri.parse(CustomUrl.url + "kermes/table/");
  final headers = {"Content-type": "application/json"};

  final json = '{ "area_name": { "area_number": ${tableArea}, "area_name": "MUTFAK" }, "table_number": "${tableNo}", "table_information": "${tableDescription}", "isEmpty": ${tableEmpty}}';
  final response = await http.post(url, headers: headers, body: json);
  print(response.body);
}

class _TableCreateState extends State<TableCreate> {
  final tableNoController = TextEditingController();
  final tableDescriptionController = TextEditingController();
  final tableAreaController = TextEditingController();
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MASA KAYIT EKRANI',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: CustomColors.palatinateBlue),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: tableNoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masa no',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tableDescriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masa bilgisi',
                  ),
                  minLines: 3,
                  maxLines: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: tableAreaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masa alanı',
                  ),
                ),
              ),
              CheckboxListTile(
                title: Text('Masa boş mu?'),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    tableCreate(
                        UserProfile.token != null ? UserProfile.token : "",
                        tableNoController.text,
                        tableDescriptionController.text,
                        tableAreaController.text,
                        isChecked);
                  },
                  child: Text('Kaydet'))
            ],
          ),
        ),
      ),
    );
  }
}
