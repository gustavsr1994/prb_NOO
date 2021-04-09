import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prb_app/feature/dashboard/dashboard-page.dart';
import 'package:http/http.dart' as http;
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

  processLogin(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var urlPostLogin = "http://192.168.0.13:8893/Api/Login?username=$username&password=$password";
    print("Ini urlPostLogin okay : $urlPostLogin");
    var jsonLogin = await http.post(Uri.parse(urlPostLogin));
    print(jsonLogin.body.toString());
    print(jsonLogin.body.toString().isEmpty);
    if(jsonLogin.body.toString().isEmpty){
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
                  color: Colors.red
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              )
            ],
          )
      );
      return false;
    }
    var dataLogin = json.decode(jsonLogin.body);
    print("Ini datalogin : $dataLogin");
    print("Ini username: $username");
    print("Ini password $password");
    if (dataLogin['Username'] ==  username
    ) {
      print("ini button login");
      prefs.setString("username", dataLogin['Username']);
      prefs.setString("password", password);
      // Go to Profile Page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardPage(
              )));
    }
    setState(() {
      txtMsg = dataLogin['Username'].toString();
    });
    print(dataLogin);
  }

  //Untuk enable-disable password
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
            children: <Widget> [
              Container(
                child: Image.asset('assets/images/prb-icon.png'),
              ),
              // SizedBox(height: 20,),
              Text(
                "LOGIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: TextFormField(
                  controller: _usernameController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: TextFormField(
                  controller: _passController,
                  textAlign: TextAlign.center,
                  autofocus: false,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off
                        : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: (){
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    hintText: 'Password',
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(65.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () async{
                    if (_formKey.currentState.validate()) {
                      print("Ini proses login");
                      processLogin(_usernameController.text, _passController.text);
                      // SignInSignUpResult result = await AuthenticationService.signInWithEmail
                      //   (
                      // email: _emailController.text, pass: _passController.text);
                      bool isSuccessLogin = true;
                    }bool isSuccessLogin = await processLogin(_usernameController.text, _passController.text);
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}