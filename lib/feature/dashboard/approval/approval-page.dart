import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prb_app/model/Approval.dart';

class ApprovalPage extends StatefulWidget {
  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {

  var urlGetApproval = "http://119.18.157.236:8893/api/FindApproval/2";
  String _valApproval;
  List<Approval> _dataApproval = [];
  void getApproval() async {
    final response = await http.get(Uri.parse(urlGetApproval));
    Iterable listData = json.decode(response.body);
    print(urlGetApproval);
    setState(() {
      _dataApproval =
          listData.map((item) => Approval.fromJson(item)).toList();
      for(Approval item in _dataApproval) {
        print("test ${item.custName}");
        this.listData.add(Container(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name : test",
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
                    "Date : 12 April 2021",
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
                    "Pending",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                //Ini row button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(
                        height: 30,
                        child: InkWell(
                          child: Text(
                            "VIEW DETAILS",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 60,
                        child: VerticalDivider(
                          thickness: 2,
                          color: Colors.orange,
                          endIndent: 15,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 30,
                        child: InkWell(
                          child: Text(
                            "VIEW DETAILS",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
      }
    });
    print("Data Approval : $listData");
  }

  List<Widget> listData =[

  ];

  void initState() {
    // TODO: implement initState
    super.initState();
    getApproval();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          "Approval",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: new Container(
        child: new ListView(
          padding: EdgeInsets.all(15),
          children: listData,
        ),
      ),
    );
  }
}