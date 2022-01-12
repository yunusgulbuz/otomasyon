

import 'package:flutter/material.dart';
import 'package:otomasyon/view/authenticate/register/register.dart';
import 'package:otomasyon/view/authenticate/user/UserProfile.dart';
import 'package:otomasyon/view/kermes/Table/Tables.dart';
import 'package:otomasyon/view/market/CustomUrl.dart';
import 'package:http/http.dart' as http;
import 'package:otomasyon/core/constants/CustomColors.dart';

import '../../../MainMenu.dart';
import 'Models/LoginModel.dart';
import 'Models/LoginSuccessModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/MarketUrunListModel.dart';
import 'Models/UsersModel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

Future login(email,password,context) async {
  final url = Uri.parse(CustomUrl.url + "kermes/login/");
  final headers = {"Content-type": "application/json"};

  final json = '{"username": "${email}", "password": "${password}"}';
  final response = await http.post(url, headers: headers, body: json);

  print('Status code: ${response.statusCode}');
  if (response.statusCode == 200) {
    // Eğer giriş yaparsa
    var result = loginSuccessModelFromJson(response.body);
    print(result.token);
    getUsers(email,password);
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MainMenu()));
    // urunList(result.token);
  } else if (response.statusCode == 401) {
    // Eğer giriş yapmazsa
    var result = loginModelFromJson(response.body);
    print(result.detail);
  }
}

Future<void> getUsers(String email,String password) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  final url = Uri.parse(CustomUrl.url + "account/user/");
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
    List<UsersModel> result = usersModelFromJson(response.body);
    result.forEach((element) {
      if(element.email == email){
        UserProfile.permission = element.userStyle.id;
        sharedPreferences.setString("email", email);
        sharedPreferences.setString("password", password);
        sharedPreferences.setInt("userStyleId", element.userStyle.id);
        print(sharedPreferences.getInt("userStyleId"));
        sharedPreferences.setString("userStyleName", element.userStyle != null ? element.userStyle.userStyle : "");
        sharedPreferences.setString("userStyleInf", element.userStyle != null ? element.userStyle.userStyleInf : "");
      }

    });
  } else {

  }
}


class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginControl();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hoşgeldiniz, ',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0,
                        color: CustomColors.palatinateBlue),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        print('Forgotted Password!');
                      },
                      child: Text(
                        'Şifremi Unuttum?',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      login(emailController.text,passwordController.text,context);
                    },
                    color: Colors.blue,
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  color: Colors.black,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''Bir hesaba sahip değil misin? ''',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print('Sign Up');
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Register()));
                      },
                      child: Text('Kayıt ol'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginControl() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if ((sharedPreferences.getString('email') != null || sharedPreferences.getString('email') != "") && (sharedPreferences.getString('password')!= null || sharedPreferences.getString('password')!= "")){
      login(sharedPreferences.getString('email'), sharedPreferences.getString('password'), context);
    }
    }
}
