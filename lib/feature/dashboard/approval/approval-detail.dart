import 'dart:convert';
import 'dart:typed_data';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prb_app/feature/dashboard/approval/approval-page.dart';
import 'package:prb_app/feature/dashboard/dashboardmanager-page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';

import '../../../model/approval.dart';

class ApprovalDetailPage extends StatefulWidget {

  int id;
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
    Key key, this.id, this.custName, this.brandName, this.category, this.segment, this.subSegment,
    this.selectclass, this.phoneNo, this.companyStatus, this.faxNo, this.contactPerson,
    this.emailAddress, this.website, this.nPWP, this.kTP, this.currency, this.priceGroup,
    this.salesman, this.salesOffice, this.businessUnit, this.fotoNPWP, this.fotoKTP, this.fotoSIUP,
    this.fotoGedung, this.custSignature, this.status,
  });

  int iduser;

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

  UploadSignatureApproval(imageFile, String namaFile) async {
    //var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    //var length = await imageFile.length();
    var uri = Uri.parse("http://119.18.157.236:8893/api/Upload");
    var request = new http.MultipartRequest("POST", uri);
    //var multipartFile = new http.MultipartFile.fromBytes('file', imageFile,
    //filename: namaFile);
    //contentType: new MediaType('image', 'png'));
    request.files.add(
        http.MultipartFile.fromBytes('file', imageFile, filename: namaFile));
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      signatureApprovalFromServer = value.replaceAll("\"", "");

    });
  }

  void getSharedPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.iduser = prefs.getInt("id");
    });
    // var id = this.widget.id;
    // var approveBy = prefs.getInt("id");
  }

  processApprovalButton(int id, String value, int approveBy, String ApprovedSignature) async{
    var urlPostApproval = "http://192.168.0.13:8893/api/Approval?id=$id&value=$value&approveBy=$approveBy&ApprovedSignature=$ApprovedSignature";
    print("Ini urlPostLogin okay : $urlPostApproval");
    var jsonApprovalButton = await http.post(Uri.parse(urlPostApproval));
    print(jsonApprovalButton.body.toString());
    print(jsonApprovalButton.body.toString().isEmpty);
    var dataApprovalButton = jsonDecode(jsonApprovalButton.body);
    print(jsonApprovalButton.body.toString());
    print(jsonApprovalButton.body.toString().isEmpty);
    if (dataApprovalButton['id'] == id){
      print("Ini button Approval");
      if(dataApprovalButton['value'] == "1" ){
        print("Ini value 1/Approve");
        Alert(context: context, title: "RFlutter", desc: "Flutter awesome").show();
      }
    }
  }

  processRejectButton(String id, String value, String approveBy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = this.widget.id;
    var approveBy = prefs.getInt("id");
    var urlPostReject = "http://192.168.0.13:8893/api/Approval?id=$id&value=$value&approveBy=$approveBy";
    print("Ini urlPostLogin okay : $urlPostReject");
    var jsonApprovalButton = await http.post(Uri.parse(urlPostReject));
    print(jsonApprovalButton.body.toString());
    print(jsonApprovalButton.body.toString().isEmpty);
    var dataApprovalButton = jsonDecode(jsonApprovalButton.body);
    print(jsonApprovalButton.body.toString());
    print(jsonApprovalButton.body.toString().isEmpty);
    if (dataApprovalButton['id'] == id){
      print("Ini button Reject");
      if(dataApprovalButton['value'] == "0" ){
        print("Ini value 0/Reject");
        Alert(context: context, title: "RFlutter", desc: "Flutter awesome").show();
      }
    }
  }

  Uint8List DataSign;
  String signatureApprovalFromServer = "SIGNATUREAPPROVAL_" + DateFormat("ddMMyyyy_hhmm").format(DateTime.now()) + "_.jpg";
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
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${widget.fotoNPWP}"
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
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${widget.fotoKTP}"
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
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${widget.fotoSIUP}"
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
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${widget.fotoGedung}"
                  )
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  "Approval\nSignature",
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

            ],
          ),
          SizedBox(height: 10,),
          Container(
            child: Column(
              children: [
                Text(""),
                SizedBox(height: 10,),
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
                        // IconButton(
                        //     icon: const Icon(Icons.check),
                        //     color: Colors.blue,
                        //     onPressed: () async {
                        //       if (_signaturecontrollerapproval.isNotEmpty){
                        //         DataSign = await _signaturecontrollerapproval.toPngBytes();
                        //         if (DataSign != null){
                        //           //await UploadSignatureSales(data, signatureSalesFromServer );
                        //         }
                        //       }
                        //     }
                        // ),
                      ],
                    ),
                  ),
                ),
                //Clear Canvass
                IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: (){
                      setState(() => _signaturecontrollerapproval.clear());
                    }
                ),
              ],
            ),
          ),
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
          SizedBox(height: 30,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () async {
                    // successDialog(
                    //     context,
                    //     "Approval Succes",
                    //   title: "Success",
                    // );
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context)=> DashboardManagerPage()));
                    DataSign = await _signaturecontrollerapproval.toPngBytes();
                    UploadSignatureApproval(DataSign, signatureApprovalFromServer);
                    getSharedPrefs();
                    processApprovalButton(widget.id, "1", widget.iduser,signatureApprovalFromServer );
                  },
                  child: Text(
                    "Approve",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20,),

                //Button Reject
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    processRejectButton("id", "0", "id");
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
