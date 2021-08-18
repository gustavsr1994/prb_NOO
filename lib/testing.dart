import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prb_app/feature/dashboard/dashboard-employee/status/status-edit-page.dart';
import 'package:prb_app/model/address.dart';
import 'package:prb_app/model/approval.dart';
import 'package:prb_app/model/approvalstatus.dart';
import 'package:prb_app/model/status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart';

class Testing extends StatefulWidget {
  const Testing({key}) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {

  List listdataApprovalStatus = [];
  Future<String> getDataApprovalStatus() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    var urlGetApprovalStatus = "http://192.168.0.13:8893/api/Approval/10390";
    print(urlGetApprovalStatus);
    Response r = await get(Uri.parse(urlGetApprovalStatus), headers: <String, String>{'authorization': basicAuth});
    // var dataApproval = json.decode(r.body.toString());
    // idNOO = dataApproval["id"].toString();
    print(r.statusCode);
    print(r.body);
    this.setState(() {
      print("ABC");
      listdataApprovalStatus = jsonDecode(r.body);
      // data.addAll(jsonDecode(r.body));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState getData: ${getDataApprovalStatus()}");
    getDataApprovalStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new  Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listdataApprovalStatus.length,
          itemBuilder: (BuildContext context, int index) {
            print("xxData: $listdataApprovalStatus");
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
                        "Name : ${listdataApprovalStatus[index]['Level']}\n"
                        "Status: ${listdataApprovalStatus[index]['Status']}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
