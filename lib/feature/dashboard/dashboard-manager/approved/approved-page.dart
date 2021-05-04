import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prb_app/feature/dashboard/dashboard-employee/status/status-detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'approved-detail.dart';


class ApprovedPage extends StatefulWidget {
  String name;
  String Role;
  ApprovedPage({Key key, this.name, this.Role}) : super(key: key);
  @override
  _ApprovedPageState createState() => _ApprovedPageState();
}

class _ApprovedPageState extends State<ApprovedPage> {

  List data;

  Future<String> getData() async {
    var urlGetApproved = "http://119.18.157.236:8893/Api/ApprovedNOO/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getInt("iduser").toString();
    print(urlGetApproved + userId);
    final response = await http.get(Uri.parse(urlGetApproved + userId));
    this.setState(() {
      data = jsonDecode(response.body);
    });
  }

  // var urlGetApproval = "http://119.18.157.236:8893/Api/ApprovedNOO/";

  List<Widget> listData = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    // getApproval();
    print("dibawah ini adalah list data card");
    print(listData);
    listData;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print("Ini Approved Page");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white60,
          title: Text(
            "Approved",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  widget.name??"",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: new Container(
          child: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                padding: EdgeInsets.all(7),
                child: Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Name : " + data[index]["CustName"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Date : " + data[index]["CreatedDate"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data[index]["Status"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 5,
                          child: Divider(
                            thickness: 1,
                            color: Colors.orange,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //Ini row button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Container(
                              height: 60,
                              child: VerticalDivider(
                                thickness: 2,
                                color: Colors.orange,
                                endIndent: 20,
                                indent: 5,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              height: 30,
                              child: InkWell(
                                  child: Text(
                                    "APPROVED DETAILS",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ApprovalDetailPage(
                                                id: data[index]["id"],
                                              )),
                                    );
                                  }),
                            ),
                          ),
                          Center(
                            child: Container(
                              height: 60,
                              child: VerticalDivider(
                                thickness: 2,
                                color: Colors.orange,
                                endIndent: 20,
                                indent: 5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
