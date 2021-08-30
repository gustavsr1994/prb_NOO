import 'dart:convert';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:prb_app/base/base-url.dart';
import 'package:prb_app/feature/dashboard/dashboard-employee/dashboardemployee-page.dart';
import 'package:prb_app/feature/dashboard/dashboard-manager/dashboardmanager-page.dart';
import 'package:prb_app/feature/login/login-presenter.dart';
import 'package:prb_app/model/user.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  String txtMsg = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Untuk enable-disable password
  bool _obscureText = true;

  String playerid;

  getPlayerIDFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      playerid = (prefs.getString("getPlayerID") ?? "");
    });
  }

  processLogin(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);

    var urlPostLogin =
        baseURL+"Login?username=$username&password=${password.replaceAll("#", "%23")}&playerId=$playerid";
    Response r = await post(Uri.parse(urlPostLogin),
        headers: <String, String>{'authorization': basicAuth});
    print(r.statusCode);
    print(r.body);
    print("Ini urlPostLogin okay : $urlPostLogin");
    var jsonLogin = await post(Uri.parse(urlPostLogin),
        headers: <String, String>{'authorization': basicAuth});
    if (jsonLogin.body.toString().isEmpty) {
      print("Aduh gagal login dong");
      // Show Dialog
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Please Check Your Username and Password !!",
              style: TextStyle(
//                fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              )
            ],
          ));
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => DashboardEmployeePage(
                  username: user?.username ?? "",
                  iduser: iduser,
                  so: user?.so,
                  bu: user?.bu,
                )),
                (Route<dynamic> route) => false);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DashboardEmployeePage(
        //           username: user.name,
        //         ),
        //     )
        // );
      } else if (dataLogin['Role'] == "1" || dataLogin['Role'] == "2") {
        print("Ini Role 1");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => DashboardManagerPage(
                  username: user.username,
                  Role: dataLogin['Role'],
                )),
                (Route<dynamic> route) => false);
      } else {
        throw Exception("Gagal Login");
      }
    }
    setState(() {
      txtMsg = dataLogin['Username'].toString();
    });
    print(dataLogin);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlayerIDFromSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    print("Ini Login Page");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // key: _formKey,
        child: Form(
          key: _formKey,
          child: ListView(
            // key: _formKey,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/prb-icon.png'),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text(
                  nooVersion,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
              // SizedBox(height: 20,),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Username!!';
                    }
                    return null;
                  },
                  controller: _usernameController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Password!!';
                    }
                    return null;
                  },
                  controller: _passController,
                  textAlign: TextAlign.center,
                  autofocus: false,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    hintText: 'Password',
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(65.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                height: 45,
                // ignore: deprecated_member_use
                child: ProgressButton(
                  // animationDuration: Duration(days:8),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  strokeWidth: 0,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: (AnimationController controller) {
                    if (controller.isCompleted) {
                      controller.reverse();
                    } else {
                      controller.forward();
                    }
                    if (_formKey.currentState.validate()) {
                      processLogin(_usernameController.text, _passController.text);
                      controller.forward();
                      print("Ini proses login");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
