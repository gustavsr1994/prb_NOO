import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../model/approval.dart';

class ApprovalDetailPage extends StatefulWidget {

  String custName;
  String brandName;
  String category;
  String segment;
  String subSegment;
  String selectclass;
  String phoneNo;
  String companyStatus;
  String faxNo;
  String contactPerson;
  String emailAddress;
  String website;
  String nPWP;
  String kTP;
  String currency;
  String priceGroup;
  String salesman;
  String salesOffice;
  String businessUnit;
  String notes;
  String fotoNPWP;
  String fotoKTP;
  String fotoSIUP;
  String fotoGedung;
  String custSignature;
  String approval1;
  String approval2;
  String status;

  ApprovalDetailPage({
    Key key, this.custName, this.brandName, this.category, this.segment, this.subSegment,
    this.selectclass, this.phoneNo, this.companyStatus, this.faxNo, this.contactPerson,
    this.emailAddress, this.website, this.nPWP, this.kTP, this.currency, this.priceGroup,
    this.salesman, this.salesOffice, this.businessUnit, this.fotoNPWP, this.fotoKTP, this.fotoSIUP,
    this.fotoGedung, this.custSignature, this.status,
  });

  @override
  _ApprovalDetailPageState createState() => _ApprovalDetailPageState();
}

class _ApprovalDetailPageState extends State<ApprovalDetailPage> {

  var urlGetApprovalDetail = "http://119.18.157.236:8893/api/FindApproval/2";
  List<Approval> _dataApprovalDetail = [];
  void getApprovalDetail() async{
    final response = await http.get(Uri.parse(urlGetApprovalDetail));
    Iterable lisData = json.decode(response.body);
    print(urlGetApprovalDetail);
    setState(() {
      _dataApprovalDetail =
          lisData.map((item) => Approval.fromJson(item)).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApprovalDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          "Approval Detail",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Customer Name"
              ),
              Center(
                child: Text(
                  ":"
              ),
              ),
              Text(
                "${widget.custName}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Brand Name"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.brandName}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Category"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.category}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Segment"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.segment}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Sub Segment"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.subSegment}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Class"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.selectclass}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Phone No"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.phoneNo}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Company Status"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.companyStatus}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Fax No"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.faxNo}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Contact Person"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.contactPerson}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Email Address"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.emailAddress}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Website"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.website}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "NPWP"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.nPWP}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "KTP"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.kTP}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Currency"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.currency}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Price Group"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.priceGroup}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Salesman"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.salesman}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Sales Office"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.salesOffice}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Business Unit"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.businessUnit}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Foto NPWP"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.fotoNPWP}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Foto KTP"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.fotoKTP}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Foto SIUP"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.fotoSIUP}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Foto Gedung"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.fotoGedung}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Customer Signature"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.custSignature}"
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "Status"
              ),
              Center(
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.status}"
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
