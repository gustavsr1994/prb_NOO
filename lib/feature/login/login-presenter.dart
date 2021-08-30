import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:prb_app/base/base-url.dart';
import 'package:prb_app/feature/dashboard/dashboard-employee/dashboardemployee-page.dart';
import 'package:prb_app/feature/dashboard/dashboard-manager/dashboardmanager-page.dart';
import 'package:prb_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


String playerid;
String txtMsg = '';

processLoginGetX(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String usernameAuth = 'test';
  String passwordAuth = 'test456';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
  print(basicAuth);

  var urlPostLogin =
      baseURL+"Login?username=$username&password=${password.replaceAll("#", "%23")}&playerId=$playerid";
  var response = await post(Uri.parse(urlPostLogin),
      headers: <String, String>{'authorization': basicAuth});
  print(response.statusCode);
  print(response.body);
  print("Ini urlPostLogin okay : $urlPostLogin");
  var jsonLogin = await post(Uri.parse(urlPostLogin),
      headers: <String, String>{'authorization': basicAuth});
  if (jsonLogin.body.toString().isEmpty) {
    print("Aduh gagal login dong");
    // Show Dialog
    Get.defaultDialog(
      title: "Error",
      content: Text("Please Check Your Username and Password !!"),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            )
      ]
    );
    return false;
  }
  var user = User.fromJson(jsonDecode(jsonLogin.body));
  print("cek ini");
  print(user.id);
  prefs.setInt("iduser", user.id);
  var iduser = (prefs.getInt("iduser"));
  print("GOMU_GOMU NO PISTOL IDUSER : $iduser ");
  print(user.username);
  print(user.name);
  print(jsonLogin.body.toString());
  print(jsonLogin.body.toString().isEmpty);
  var dataLogin = json.decode(jsonLogin.body);
  print("Ini datalogin : $dataLogin");
  print("Ini username: $username");
  print("Ini password $password");
  if (dataLogin['Username'] == username) {
    print("ini button login");
    prefs.setString("username", dataLogin['Username']);
    prefs.setString("password", password);
    prefs.setInt("iduser", user.id); //tidak digunkan karena sudah di llne 30
    prefs.setString("name", user.name);
    //Buat login beda page
    if (dataLogin['Role'] == "0") {
      print("Ini role 0");
      Get.offAll(DashboardEmployeePage(
        username: user?.username ?? "",
        iduser: iduser,
        so: user?.so,
        bu: user?.bu,
      ));
    } else if (dataLogin['Role'] == "1" || dataLogin['Role'] == "2") {
      print("Ini Role 1");
      Get.offAll(DashboardManagerPage(
        username: user.username,
        Role: dataLogin["Role"],
      ));
    } else {
      throw Exception("Gagal Login");
    }
  }
  Obx(()=>txtMsg = dataLogin["Username"]);
  print(dataLogin);
}