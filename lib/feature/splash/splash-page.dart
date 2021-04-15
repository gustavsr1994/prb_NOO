import 'package:flutter/material.dart';
import 'package:prb_app/feature/dashboard/approval/approval-page.dart';
import 'package:prb_app/feature/dashboard/dashboardemployee-page.dart';
import 'package:prb_app/feature/login/login-page.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {

    print("ini splash page");
//    print(fetchToken());

    return new SplashScreen(
        seconds: 3,
//        navigateAfterSeconds: new ApprovalPage(),
        navigateAfterSeconds: new LoginPage(),
//        navigateAfterSeconds: new DashboardPage(),
        title: new Text('Welcome In Prambanan Kencana App '),
        image: new Image.asset('assets/images/prb-icon.png',),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100,
        loaderColor: Colors.red,
    );
  }
}