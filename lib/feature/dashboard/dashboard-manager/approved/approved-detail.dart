import 'dart:convert';
import 'dart:typed_data';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prb_app/model/address.dart';
import 'package:prb_app/model/approval.dart';
import 'package:prb_app/model/status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';

class ApprovalDetailPage extends StatefulWidget {
  int id;

  ApprovalDetailPage({
    Key key,
    this.id,
  });

  @override
  _ApprovalDetailPageState createState() => _ApprovalDetailPageState();
}

class _ApprovalDetailPageState extends State<ApprovalDetailPage> {
  Status data = new Status();
  Address dataCompanyAddress = new Address();
  Address dataDeliveryAddress = new Address();
  Address dataTAXAddress = new Address();

  List<Approval> _dataApprovalDetail = [];
  void getStatusDetail() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    var urlGetApprovalDetail =
        "http://119.18.157.236:8893/api/NOOCustTables/" + widget.id.toString();
    final response = await http.get(Uri.parse(urlGetApprovalDetail),headers: <String,String>{'authorization': basicAuth});
    final listData = json.decode(response.body);
    var DataCompany = (listData as Map<String, dynamic>)["CompanyAddresses"];
    var DataDelivery = (listData as Map<String, dynamic>)["DeliveryAddresses"];
    var DataTAX = (listData as Map<String, dynamic>)["TaxAddresses"];
    print(urlGetApprovalDetail);
    setState(() {
      data = Status.fromJson(listData);
    });
    setState(() {
      dataCompanyAddress = Address.fromJson(DataCompany);
    });
    setState(() {
      dataDeliveryAddress = Address.fromJson(DataDelivery);
    });
    setState(() {
      dataTAXAddress = Address.fromJson(DataTAX);
    });
  }

  UploadSignatureApproval(imageFile, String namaFile) async {
    var uri = Uri.parse("http://119.18.157.236:8893/api/Upload");
    var request = new http.MultipartRequest("POST", uri);
    request.files.add(
        http.MultipartFile.fromBytes('file', imageFile, filename: namaFile));
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      signatureApprovalFromServer = value.replaceAll("\"", "");
    });
  }

  var iduser = 0;

  void getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print("ini printan line 99 & 100");
      print(prefs.getInt("iduser"));
      iduser = prefs.getInt("iduser");
    });
  }

  Uint8List DataSign;
  String signatureApprovalFromServer = "SIGNATUREAPPROVAL_" +
      DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) +
      "_.jpg";
  //SignatureController Sales
  final SignatureController _signaturecontrollerapproval = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatusDetail();
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {

    print("ini approval detail");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          "Status Detail",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Text(
                "Customer Name     :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.custName ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Brand Name            :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.brandName ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Category                  :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.category ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Segment                  :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.segment ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Sub Segment          :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.subSegment ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Class                        :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.selectclass ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Phone No                 :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.phoneNo ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Company Status     :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.companyStatus ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Fax No                      :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.faxNo ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Contact Person       :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.contactPerson ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Email Address         :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.emailAddress ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Website                    :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.website ?? "",
                style: TextStyle(fontSize: 17, color: Colors.black54),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "NPWP                       :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.nPWP ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "KTP                           :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.kTP ?? "",
                style: TextStyle(fontSize: 17, color: Colors.black54),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Currency                   :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.currency ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Price Group              :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.priceGroup ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Salesman                 :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.salesman ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Sales Office              :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.salesOffice ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Business Unit           :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.businessUnit ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          SizedBox(height: 10,),

          //Company Address
          Center(
            child: Text(
              "Company Address",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text(
                "Name                        :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataCompanyAddress.name ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Street Name            :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataCompanyAddress.streetName ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "City                            :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataCompanyAddress.city ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Country                     :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataCompanyAddress.country ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "State                         :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataCompanyAddress.state ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "ZIP Code                  :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataCompanyAddress.zipCode.toString(),
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          SizedBox(height: 10,),

          //Ini TAX Address
          Center(
            child: Text(
              "TAX Address",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text(
                "Name                        :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataTAXAddress.name ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Street Name            :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataTAXAddress.streetName ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "City                            :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataTAXAddress.city ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Country                     :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataTAXAddress.country ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "State                          :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataTAXAddress.state ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "ZIP Code                   :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataTAXAddress.zipCode.toString(),
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          SizedBox(height: 10,),

          //Ini Delivery Address
          Center(
            child: Text(
              "Delivery Address",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text(
                "Name                        :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataDeliveryAddress.name ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Street Name            :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataDeliveryAddress.streetName ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "City                            :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataDeliveryAddress.city ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Country                     :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataDeliveryAddress.country ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "State                          :   ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataDeliveryAddress.state ?? "",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "ZIP Code                   :   ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                dataDeliveryAddress.zipCode.toString(),
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          SizedBox(height: 10,),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                "Foto NPWP             :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Container(
                  height: 100,
                  // child: data.fotoNPWP != null ? Container() : "null" == data.fotoNPWP ? Container():
                  child: InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) => Image.network(
                          "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.fotoNPWP}",
                        ),
                      );
                    },
                    child: Image.network(
                      "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.fotoNPWP}",
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Foto KTP                 :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Container(
                height: 100,
                child:
                // data.fotoKTP != null ? Container():
                InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => Image.network(
                        "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.fotoKTP}",
                      ),
                    );
                  },
                  child: Image.network(
                    "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.fotoKTP}",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Foto SIUP               :      ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Container(
                height: 100,
                child:
                // data.fotoSIUP != null ? Container():
                InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => Image.network(
                        "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.fotoSIUP}",
                      ),
                    );
                  },
                  child: Image.network(
                    "http://119.18.157.236:8893//api/Files/GetFiles?fileName=${data.fotoSIUP}",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Foto Gedung         :       ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Container(
                height: 100,
                child:
                // data.fotoGedung != null ? Container():
                InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => Image.network(
                        "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.fotoGedung}",
                      ),
                    );
                  },
                  child: Image.network(
                    "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.fotoGedung}",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Approval 1\nSignature",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(62, 0, 20, 0),
                child: Text(":"),
              ),
              Flexible(
                child: Container(
                  height: 100,
                  child: InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) => Image.network(
                          "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.approval1Signature}",
                        ),
                      );
                    },
                    child: Image.network(
                      "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.approval1Signature}",
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Approval 2\nSignature",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(62, 0, 20, 0),
                child: Text(":"),
              ),
              Flexible(
                child: Container(
                  height: 100,
                  // width: 100,
                  child: InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) => Image.network(
                          "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.approval2Signature}",
                        ),
                      );
                    },
                    child: Image.network(
                      "http://119.18.157.236:8893/api/Files/GetFiles?fileName=${data.approval2Signature}",
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                "Remark                     :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                data.remark ?? "",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
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
                child: Text(":"),
              ),
              Text(
                data.status ?? "",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}