import 'package:flutter/material.dart';
import 'package:prb_app/feature/dashboard/Signature/signature-page.dart';
import 'package:prb_app/feature/dashboard/approval/approval-page.dart';
import 'package:prb_app/feature/dashboard/taxadress/taxaddress-page.dart';
import 'package:prb_app/feature/splash/splash-page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Signature/signature-page-alt.dart';
import 'companyaddress/companyaddress-page.dart';
import 'customername/customer-page.dart';
import 'deliveryaddress/deliveryaddress-page.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DashboardManagerPage extends StatefulWidget {
//  String email;
//  DashboardManagerPage({Key key, this.email}) : super(key: key);

  @override
  _DashboardManagerPageState createState() => _DashboardManagerPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DashboardManagerPageState extends State<DashboardManagerPage> {
  int _selectedItemIndex = 0;

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashPage()), (Route<dynamic>route) => false);
  }

  @override
  Widget build(BuildContext context) {

    final List pages = [
      ApprovalPage(),
    ];

    print("Ini bottom nav");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                title: Text("Customer Form",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  ),
                ),
                icon: Icon(Icons.person,
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
                      logoutUser();
                    });
                  },
                ),
              ),
            ],
          ),
          body: pages[_selectedItemIndex]
      ),
    );
  }
}