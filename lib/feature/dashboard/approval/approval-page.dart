import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prb_app/model/Approval.dart';
import 'package:prb_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'approval-detail.dart';
import 'approval-detail.dart';

class ApprovalPage extends StatefulWidget {
  @override

  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {

  List data;
  Future<String> getData() async {
    var urlGetApproval = "http://119.18.157.236:8893/api/FindApproval/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getInt("iduser").toString();
    print(urlGetApproval + userId);
    final response = await http.get(Uri.parse(urlGetApproval + userId));
    this.setState(() {
      data = jsonDecode(response.body);
    });
  }

  var urlGetApproval = "http://119.18.157.236:8893/api/FindApproval/";

  List<Approval> _dataApproval = [];
  void getApproval() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =  prefs.getInt("iduser").toString();
    print(urlGetApproval+userId);
    final response = await http.get(Uri.parse(urlGetApproval+userId));
    print("response="+response.body);
    Iterable listData = jsonDecode(response.body);
    print("--");
    print(listData.runtimeType.toString());
    if(mounted)setState(() {
      _dataApproval =
          listData.map((item) {print(item.runtimeType.toString());
          return Approval.fromJson(item);}).toList();
      for(Approval item in _dataApproval) {
        print(item.toString());
        print("test nama ${item.custName}");
        print("test date ${item.createdDate}");
        print("test date ${item.status}");
        this.listData.add(Container(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name : ${item.custName}",
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
                    "Date : ${item.createdDate}",
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
                    "${item.status}",
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
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ApprovalDetailPage(
                                id: item.id,
                              )),
                            );
                          }
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
                            "ADJUSTMENT LEAVE",
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
    // getApproval();
    print("dibawah ini adalah list data card");
    print(listData);
    listData;
    getData();

  }

  @override
  Widget build(BuildContext context) {

    print("Ini Approval Page");

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
          child: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                child: Card(
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
                      SizedBox(
                        height: 5,
                      ),
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
                                endIndent: 15,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              height: 30,
                              child: InkWell(
                                child: Text(
                                  "ADJUSTMENT LEAVE",
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
              );
            },
          ),
        ));
  }
}