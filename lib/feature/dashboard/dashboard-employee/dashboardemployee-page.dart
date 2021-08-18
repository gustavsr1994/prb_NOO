import 'package:flutter/material.dart';
import 'package:prb_app/feature/dashboard/dashboard-employee/status/status-page.dart';
import 'package:prb_app/feature/splash/splash-page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'customer/customer-page.dart';

class DashboardEmployeePage extends StatefulWidget {
  String username;
  int iduser;
  String so;
  String bu;
  DashboardEmployeePage({Key key, this.username, this.iduser, this.bu, this.so}) : super(key: key);

  @override
  _DashboardEmployeePageState createState() => _DashboardEmployeePageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DashboardEmployeePageState extends State<DashboardEmployeePage> {
  int _selectedItemIndex = 1;

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashPage()), (Route<dynamic>route) => false);
  }

  String longitudeData = "";
  String latitudeData = "";
  String addressDetail = "";
  String streetName = "";
  String city = "";
  String countrys = "";
  String state = "";
  String zipCode = "";
  String salesmanId = "";

  loadLongLatFromSharedPrefs() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    setState(() {
      streetName = (prefs.getString("getStreetName")??"");
      city = (prefs.getString("getCity")??"");
      countrys = (prefs.getString("getCountry")??"");
      state = (prefs.getString("getState")??"");
      zipCode = (prefs.getString("getZipCode")??"");
      longitudeData = (prefs.getString("getLongitude")??"");
      latitudeData = (prefs.getString("getLatitude")??"");
      addressDetail = (prefs.getString("getAddressDetail")??"");
      print("ini loadlonglat: $longitudeData");
      print("Ini addressDetail: $addressDetail");
      print("ini detail street: $streetName");
      print("ini detail city: $city");
      print("ini detail country: $countrys");
      print("ini detail state: $state");
      print("ini detail zipcode: $zipCode");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLongLatFromSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {

    showAlertDialog(BuildContext context) {
      // set up the buttons
      // ignore: deprecated_member_use
      Widget cancelButton = FlatButton(
        child: Text("No"),
        onPressed:  () {
          Navigator.pop(context);
        },
      );
      // ignore: deprecated_member_use
      Widget continueButton = FlatButton(
        child: Text("Yes"),
        onPressed:  () {
          logoutUser();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("AlertDialog"),
        content: Text("Are You Sure Want to Logout?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    final List pages = [
      CustomerPage(
        name: widget.username,
        iduser: widget.iduser,
        zipCode: zipCode,
        streetName: streetName,
        longitudeData: longitudeData,
        countrys: countrys,
        city: city,
        state: state,
        addressDetail: addressDetail,
        latitudeData: latitudeData,
        so: widget.so,
        bu: widget.bu,
      ),
      StatusPage(name: widget.username),
      InkWell(
        child: Icon(
          Icons.logout,
        ),
        onTap: () {
          setState(() {
            showAlertDialog(context);
          });
        },
      ),
    ];

    print("Ini bottom nav");
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            elevation: 50,
            backgroundColor: Color(0xFFF0F0F0),
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.red,
            selectedIconTheme: IconThemeData(color: Colors.red[600]),
            currentIndex: _selectedItemIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                _selectedItemIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                title: Text("New",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  ),
                ),
                icon: Icon(Icons.person,
                ),
              ),
              BottomNavigationBarItem(
                title: Text("List",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  ),
                ),
                icon: Icon(Icons.book,
                ),
              ),
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text("Logout",
                  textAlign: TextAlign.center,
                ),
                icon: InkWell(
                  child: Icon(
                    Icons.logout,
                  ),
                  onTap: () {
                        setState(() {
                          showAlertDialog(context);
                        });
                  },
                ),
              ),
            ],
          ),
          body: pages[_selectedItemIndex??""]
      );
  }
}