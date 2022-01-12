import 'package:flutter/material.dart';
import 'package:otomasyon/view/authenticate/user/UserProfile.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';
import 'package:http/http.dart' as http;
class CustomDialog extends StatefulWidget {

  bool mov = false;
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  // var formatter = new DateFormat('dd-MM-yyyy');
  late bool edit = false;

  int _groupValueRadio = 1;
  Color _colorContainer = Colors.green;
  Color _colorTextButtom = Colors.green;

  final tableNoController = TextEditingController();
  final tableDescriptionController = TextEditingController();
  final tableAreaController = TextEditingController();
  bool isChecked = true;
  tableCreate(token,tableNo,tableDescription,tableArea,tableEmpty) async {
    print(int.parse(tableArea)+5);
    final url = Uri.parse(CustomUrl.url + "kermes/tableAdding/");
    final headers = {"Content-type": "application/json"};

    final json = '{"table_number": "${int.parse(tableNo)}", "table_information": "${tableDescription}", "isEmpty": "$tableEmpty", "table_area": "${int.parse(tableArea)}"}';
    final response = await http.post(url, headers: headers, body: json);
    print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.050)),
        title: Text(
          "Masa Ekle",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: _colorContainer,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Masa No ",
                    style:
                    TextStyle(color: Colors.white, fontSize: width * 0.05),
                  ),
                  Flexible(
                    child: TextField(
                        controller: tableNoController,
                        maxLength: 7,
                        style: TextStyle(fontSize: width * 0.05),
                        keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        decoration: new InputDecoration(
                          hintText: "",
                          hintStyle: TextStyle(color: Colors.white54),
                          contentPadding:  EdgeInsets.only(
                              left: width * 0.04,
                              top: width * 0.041,
                              bottom: width * 0.041,
                              right: width * 0.04),//15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        )),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Alan No ",
                      style:
                      TextStyle(color: Colors.white, fontSize: width * 0.05),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                        controller: tableAreaController,
                        maxLength: 7,
                        style: TextStyle(fontSize: width * 0.05),
                        keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        decoration: new InputDecoration(
                          hintText: "",
                          hintStyle: TextStyle(color: Colors.white54),
                          contentPadding:  EdgeInsets.only(
                              left: width * 0.04,
                              top: width * 0.041,
                              bottom: width * 0.041,
                              right: width * 0.04),//15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        )),
                  )
                ],
              ),

              TextField(
                  controller: tableDescriptionController,
                  maxLength: 20,
                  style: TextStyle(fontSize: width * 0.05),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    //hintText: "descrição",
                    labelText: "Masa Açıklaması",
                    labelStyle: TextStyle(color: Colors.white54),
                    //hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding:  EdgeInsets.only(
                        left: width * 0.04,
                        top: width * 0.041,
                        bottom: width * 0.041,
                        right: width * 0.04),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  )),
              Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.green[900],
                    value: 1,
                    groupValue: _groupValueRadio,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _groupValueRadio = 1;
                        isChecked = true;
                        _colorContainer = Colors.green;
                        _colorTextButtom = Colors.green;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: Text("Boş"),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.red[900],
                    value: 2,
                    groupValue: _groupValueRadio,
                    onChanged: (value){
                      print(value);
                      setState(() {
                        _groupValueRadio = 2;
                        isChecked = false;
                        _colorContainer = Colors.red;
                        _colorTextButtom = Colors.red;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: Text("Dolu"),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: width * 0.09),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        "İptal",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){

                        if(tableNoController.text.isNotEmpty && tableAreaController.text.isNotEmpty){
                          tableCreate(UserProfile.token,tableNoController.text,tableDescriptionController.text,tableAreaController.text,isChecked);
                          Navigator.pop(context);
                          //initState();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: width * 0.02,
                            bottom: width * 0.02,
                            left: width * 0.03,
                            right: width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text("Kaydet",
                            style: TextStyle(
                                color: _colorTextButtom,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
