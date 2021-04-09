import 'package:flutter/material.dart';
import 'package:prb_app/feature/dashboard/dashboard-page.dart';
import 'package:prb_app/feature/login/login-page.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
//  Future<http.Response> fetchToken() async {
//    prefs = await SharedPreferences.getInstance();
//    final response = await http.get(
//      'https://dealer.kotaawan.com/ajax/gettoken',
//    );
//    final responseJson = jsonDecode(response.body);
//    prefs.setString("tokenID",responseJson["tokenID"]);
//    sessionID = prefs.getString("SessionID");
//    print(responseJson);
//  }
//
//  SharedPreferences prefs;
//  String sessionID;
//  String email;

//  @override
//  void initState() {
//    fetchToken();
//    getSessionID();
//    super.initState();
//  }

//  getSessionID() async {
//    prefs = await SharedPreferences.getInstance();
//    // final response = await http.get(
//    //   'https://dealer.kotaawan.com/ajax/gettoken',
//    // );
//    // final responseJson = jsonDecode(response.body);
//    // prefs.setString("tokenID",responseJson["tokenID"]);
//    sessionID = prefs.getString("SessionID");
//    email = prefs.getString("email");
//    print(sessionID);
//    // print(responseJson);
//  }

  @override
  Widget build(BuildContext context) {


    print("ini splash page");
//    print(fetchToken());

    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new LoginPage(),
//        navigateAfterSeconds: new DashboardPage(),
        title: new Text('Welcome In Prambanan Kencana App '),
        image: new Image.asset('assets/images/prb-icon.png',),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 200,
        loaderColor: Colors.red,
    );
  }
}