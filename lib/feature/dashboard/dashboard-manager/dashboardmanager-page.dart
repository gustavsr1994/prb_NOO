import 'package:abhi_flutter_alertdialog/abhi_flutter_alertdialog.dart';
import 'package:flutter/material.dart';
import 'package:prb_app/feature/splash/splash-page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'approval/approval-page.dart';
import 'approved/approved-page.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DashboardManagerPage extends StatefulWidget {
  String username;
  String Role;
  DashboardManagerPage({Key key, this.username, this.Role}) : super(key: key);

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
        MaterialPageRoute(builder: (context) => SplashPage()), (Route<dynamic>route) => false
    );
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
      ApprovalPage(name: widget.username, Role: widget.Role,),
      ApprovedPage(name: widget.username, Role: widget.Role),
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
                title: Text("List",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  ),
                ),
                icon: Icon(Icons.person,
                ),
              ),
              BottomNavigationBarItem(
                title: Text("Approved",
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
          body: pages[_selectedItemIndex]
      ),
    );
  }
}