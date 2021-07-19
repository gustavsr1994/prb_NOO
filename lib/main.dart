import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prb_app/feature/dashboard/dashboard-employee/customer/customer-page.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String longitudeData;
  String latitudeData;
  String addressDetail = "";
  String streetName = "";
  String city = "";
  String countrys = "";
  String state = "";
  String zipCode = "";

  getCurrentLocation()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,localeIdentifier: "en");
    Placemark placeMark = placemarks[0];
    String street = placeMark.street;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String subAdministrativeArea = placeMark.subAdministrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    String address = "${street}, ${subLocality}, ${locality}, ${subAdministrativeArea}, ${administrativeArea}, ${postalCode}, ${country}";
    print(address);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      longitudeData = "${position.longitude}";
      latitudeData = "${position.latitude}";
      streetName = street;
      city = subAdministrativeArea;
      countrys = administrativeArea;
      state = country;
      zipCode = postalCode;
      addressDetail = address;
      prefs.setString("getStreetName", streetName);
      prefs.setString("getCity", city);
      prefs.setString("getCountry", countrys);
      prefs.setString("getState", state);
      prefs.setString("getZipCode", zipCode);
      prefs.setString("getAddressDetail", addressDetail);
      prefs.setString("getLongitude", longitudeData);
      prefs.setString("getLatitude", latitudeData);
      print("Ini long : ${longitudeData}");
      print("Ini lat : ${latitudeData}");
      print("ini detail street: ${streetName}");
      print("ini detail city: ${city}");
      print("ini detail country: ${countrys}");
      print("ini detail state: ${state}");
      print("ini detail zipcode: ${zipCode}");
    });
  }

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
    getCurrentLocation();
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
      // home: CustomerPage(),
      home: SplashPage(),
      // home: SplashPage(),
    );
  }
}