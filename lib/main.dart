import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'feature/splash/splash-page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // OneSignal.shared.init(
  //     "1e72c3a5-63f4-447a-a56e-8aeda29e46d3", iOSSettings:null,
  // );
  // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = "title";
  String content = "content";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
    //   // will be called whenever a notification is received
    //   setState(() {
    //     title = notification.payload.title;
    //     content = notification.payload.body;
    //   });
    // });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // will be called whenever a notification is opened/button pressed.
      print("Ini notifikasi di tap");
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRB NOO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      // home: SplashPage(),
    );
  }
}