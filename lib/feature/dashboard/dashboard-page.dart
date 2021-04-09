import 'package:flutter/material.dart';
import 'package:prb_app/feature/dashboard/Signature/signature-page.dart';
import 'package:prb_app/feature/dashboard/taxadress/taxaddress-page.dart';
import 'package:prb_app/feature/splash/splash-page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Signature/signature-page-alt.dart';
import 'companyaddress/companyaddress-page.dart';
import 'customername/customer-page.dart';
import 'deliveryaddress/deliveryaddress-page.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DashboardPage extends StatefulWidget {
  String email;
  DashboardPage({Key key, this.email}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DashboardPageState extends State<DashboardPage> {
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
      CustomerNamePage(),
      CompanyAddressPage(),
      TaxAddressPage(),
      DeliveryAddressPage(),
      SignaturePage(),
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
                title: Text("Customer \n Form",
                  textAlign: TextAlign.center,
                  style: TextStyle(
//                    fontSize: 15,
                  ),
                ),
                icon: Icon(Icons.person,
//                  size: 20,
                ),
              ),
              BottomNavigationBarItem(
                title: Text("Company \n Address",
                  textAlign: TextAlign.center,
                ),
                icon: Icon(FontAwesome.building,
//                size: 18,
                ),
              ),
              BottomNavigationBarItem(
                title: Text("Tax \n Address",
                  textAlign: TextAlign.center,
                ),
                icon: Icon(Icons.attach_money),
              ),
              BottomNavigationBarItem(
                title: Text("Delivery \n Address"),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text("Signature \n Form"),
                icon: Icon(FontAwesome.pencil),
              ),
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text(""),
                icon: IconButton(
                  icon: Icon(
                    Icons.logout,
                    size: 18,

                  ),
                  onPressed: (){
                    setState(() {
                      logoutUser();
                    });
                  },
                ),
              ),
            ],
          ),
//          body: IndexedStack(
//            children: pages,
//            index: _selectedItemIndex,
//          ),
          body: pages[_selectedItemIndex]
      ),
    );
  }
}