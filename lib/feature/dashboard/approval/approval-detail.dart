import 'dart:convert';
import 'dart:typed_data';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prb_app/feature/dashboard/approval/approval-page.dart';
import 'package:prb_app/feature/dashboard/dashboardmanager-page.dart';
import 'package:prb_app/model/address.dart';
import 'package:prb_app/model/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';

import '../../../model/approval.dart';

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
  Approval dataApproval = new Approval();
  Address dataCompanyAddress = new Address();
  Address dataDeliveryAddress = new Address();
  Address dataTAXAddress = new Address();


  List<Approval> _dataApprovalDetail = [];
  void getApprovalDetail() async {
    var urlGetApprovalDetail =
        "http://119.18.157.236:8893/api/NOOCustTables/" + widget.id.toString();
    final response = await http.get(Uri.parse(urlGetApprovalDetail));
    final listData = json.decode(response.body);
    var DataCompany = (listData as Map<String, dynamic>)["CompanyAddresses"];
    var DataDelivery = (listData as Map<String, dynamic>)["DeliveryAddresses"];
    var DataTAX = (listData as Map<String, dynamic>)["TaxAddresses"];
    print(urlGetApprovalDetail);
    setState(() {
      dataApproval = Approval.fromJson(listData);
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
      print(prefs.getInt("iduser"));
      iduser = prefs.getInt("iduser");
    });
    // var id = this.widget.id;
    // var approveBy = prefs.getInt("id");
  }

  processApprovalButton(
      int id, String value, int approveBy, String ApprovedSignature) async {
    var urlPostApproval =
        "http://192.168.0.13:8893/api/Approval?id=$id&value=$value&approveBy=$approveBy&ApprovedSignature=$ApprovedSignature";
    print("Ini urlPost Approval : $urlPostApproval");
    var jsonApprovalButton = await http.post(Uri.parse(urlPostApproval));
    // var user = User.fromJson(json.decode(jsonApprovalButton.body)); //maaf ngga kepake
    // approveBy = user.id;
    print(jsonApprovalButton.body.toString());
    print(jsonApprovalButton.body.toString().isEmpty);
    // var dataApprovalButton = jsonDecode(jsonApprovalButton.body); //maaf ngga kepake
    print(jsonApprovalButton.body.toString());
    print(jsonApprovalButton.body.toString().isEmpty);
    // if (dataApprovalButton['id'] == id){
    //   print("Ini button Approval");
    //   if(dataApprovalButton['value'] == "1" ){
    //     print("Ini value 1/Approve");
    //     Alert(context: context, title: "RFlutter", desc: "Flutter awesome").show();
    //   }
    // }
  }

  processRejectButton(int id, int value, int approveBy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = this.widget.id;
    var approveBy = prefs.getInt("iduser");
    var urlPostReject =
        "http://192.168.0.13:8893/api/Approval?id=$id&value=$value&approveBy=$approveBy";
    print("Ini urlPostReject okay : $urlPostReject");
    var jsonRejectButton = await http.post(Uri.parse(urlPostReject));
    var dataRejectButton = jsonDecode(jsonRejectButton.body);
    if (dataRejectButton['id'] == id) {
      print("Ini button Reject");
      if (dataRejectButton['value'] == "0") {
        print("Ini value 0/Reject");
        Alert(context: context, title: "RFlutter", desc: "Flutter awesome")
            .show();
      }
    }
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
    getApprovalDetail();
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print("ini approval detail");

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
                dataApproval.custName ?? "",
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
                dataApproval.brandName ?? "",
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
                dataApproval.category ?? "",
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
                dataApproval.segment ?? "",
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
                dataApproval.subSegment ?? "",
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
                dataApproval.selectclass ?? "",
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
                dataApproval.phoneNo ?? "",
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
                dataApproval.companyStatus ?? "",
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
                dataApproval.faxNo ?? "",
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
                dataApproval.contactPerson ?? "",
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
                dataApproval.emailAddress ?? "",
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
                dataApproval.website ?? "",
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
                dataApproval.nPWP ?? "",
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
                dataApproval.kTP ?? "",
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
                dataApproval.currency ?? "",
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
                dataApproval.priceGroup ?? "",
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
                dataApproval.salesman ?? "",
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
                dataApproval.salesOffice ?? "",
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
                dataApproval.businessUnit ?? "",
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
                  child: Image.network(
                    "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${dataApproval.fotoNPWP}",
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
                Image.network(
                  "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${dataApproval.fotoKTP}",
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
                Image.network(
                  "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${dataApproval.fotoSIUP}",
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
                Image.network(
                  "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${dataApproval.fotoGedung}",
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
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Approval\nSignature               : ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                Text(""),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Signature(
                    controller: _signaturecontrollerapproval,
                    height: 300,
                    backgroundColor: Colors.white,
                  ),
                ),
                //Oke dan button clear
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Container(
                    width: 355,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                      ],
                    ),
                  ),
                ),
                //Clear Canvass
                IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() => _signaturecontrollerapproval.clear());
                    }),
              ],
            ),
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
                dataApproval.status ?? "",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () async {
                    print("Ini proses approval");
                    DataSign = await _signaturecontrollerapproval.toPngBytes();
                    UploadSignatureApproval(
                        DataSign, signatureApprovalFromServer);
                    await getSharedPrefs();
                    processApprovalButton(
                        widget.id, "1", iduser, signatureApprovalFromServer
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardManagerPage()));
                    // Navigator.pop(context);
                    successDialog(
                      context,
                      "Success",
                    );
                  },
                  child: Text(
                    "Approve",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                //Button Reject
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    getSharedPrefs();
                    processRejectButton(widget.id, 0, iduser);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardManagerPage()));
                    infoDialog(context, "Rejected");
                  },
                  child: Text(
                    "Reject",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}