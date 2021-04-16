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
            children: [
              Text(
                  "Customer Name",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  ":"
              ),
              ),
              Text(
                "${widget.custName}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Brand Name",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.brandName}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Category",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(75, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.category}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Segment",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(76, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.segment}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Sub Segment",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(43, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.subSegment}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Class",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(102, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.selectclass}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Phone No",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(69, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.phoneNo}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Company Status",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.companyStatus}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Fax No",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(92, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.faxNo}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Contact Person",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(28, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.contactPerson}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Email Address",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(36, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.emailAddress}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Website",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(84, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.website}",
                style: TextStyle(
                    fontSize: 17,
                  color: Colors.black54
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "NPWP",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(96, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.nPWP}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "KTP",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(113, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.kTP}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(

            children: [
              Text(
                  "Currency",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(77, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.currency}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Price Group",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(56, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.priceGroup}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Salesman",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(70, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.salesman}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Sales Office",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(55, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.salesOffice}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Business Unit",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(41, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.businessUnit}",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Foto NPWP",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(57, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Container(
                height: 100,
                  child: Image.network(
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=no-image.png"
                  )
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Foto KTP",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(74, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Container(
                  height: 100,
                  child: Image.network(
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=no-image.png"
                  )
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Foto SIUP",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(70, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Container(
                  height: 100,
                  child: Image.network(
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=no-image.png"
                  )
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Foto Gedung",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(49, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Container(
                  height: 100,
                  child: Image.network(
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=no-image.png"
                  )
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Customer\nSignature",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(72, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Container(
                  height: 100,
                  child: Image.network(
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=no-image.png"
                  )
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Status",
                style: TextStyle(
                   fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(98, 0, 20, 0),
                child: Text(
                    ":"
                ),
              ),
              Text(
                  "${widget.status}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
