import 'dart:convert';
import 'dart:typed_data';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prb_app/feature/dashboard/approval/approval-page.dart';
import 'package:prb_app/feature/dashboard/dashboardmanager-page.dart';
import 'package:prb_app/model/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';

import '../../../model/approval.dart';

class ApprovalDetailPage extends StatefulWidget {

  int id;

  ApprovalDetailPage({
    Key key, this.id,
  });


  @override
  _ApprovalDetailPageState createState() => _ApprovalDetailPageState();
}

class _ApprovalDetailPageState extends State<ApprovalDetailPage> {

  Approval data = new Approval();

  List<Approval> _dataApprovalDetail = [];
  void getApprovalDetail() async{
    var urlGetApprovalDetail = "http://119.18.157.236:8893/api/NOOCustTables/"+widget.id.toString();
    final response = await http.get(Uri.parse(urlGetApprovalDetail));
    final listData = json.decode(response.body);
    print(urlGetApprovalDetail);
    setState(() {
      data = Approval.fromJson(listData);
      // _dataApprovalDetail = lisData.map((item) => Approval.fromJson(item)).toList();
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

  void getSharedPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print("ini printan line 99 & 100");
      print(prefs.getInt("iduser"));
      iduser = prefs.getInt("iduser");
    });
    // var id = this.widget.id;
    // var approveBy = prefs.getInt("id");
  }

  processApprovalButton(int id, String value, int approveBy, String ApprovedSignature) async{
    var urlPostApproval = "http://192.168.0.13:8893/api/Approval?id=$id&value=$value&approveBy=$approveBy&ApprovedSignature=$ApprovedSignature";
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

  processRejectButton(String id, String value, String approveBy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = this.widget.id;
    var approveBy = prefs.getInt("iduser");
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
                data.custName??"",
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
                  data.brandName??"",
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
                  data.category??"",
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
                  data.segment??"",
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
                  data.subSegment??"",
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
                  data.selectclass??"",
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
                  data.phoneNo??"",
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
                  data.companyStatus??"",
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
                  data.faxNo??"",
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
                  data.contactPerson??"",
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
                  data.emailAddress??"",
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
                  data.website??"",
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
                  data.nPWP??"",
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
                  data.kTP??"",
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
                  data.currency??"",
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
                  data.priceGroup??"",
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
                  data.salesman??"",
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
                  data.salesOffice??"",
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
                  data.businessUnit??"",
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
                  // child: data.fotoNPWP != null ? Container() : "null" == data.fotoNPWP ? Container():
                  child:
                  Image.network(
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${data.fotoNPWP}"
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
                  child:
                  // data.fotoKTP != null ? Container():
                  Image.network(
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${data.fotoKTP}"
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
                  child:
                  // data.fotoSIUP != null ? Container():
                  Image.network(
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${data.fotoSIUP}"
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
                  child:
                  // data.fotoGedung != null ? Container():
                  Image.network(
                      "http://192.168.0.13:8893/api/Files/GetFiles?fileName=${data.fotoGedung}"
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
                  data.status??"",
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
                    print("Ini proses approval");
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> ApprovalPage())).then((value){
                          setState(() {
                           ApprovalPage() == value;
                          });
                    });
                    DataSign = await _signaturecontrollerapproval.toPngBytes();
                    UploadSignatureApproval(DataSign, signatureApprovalFromServer);
                    await getSharedPrefs();
                    processApprovalButton(widget.id, "1", iduser,signatureApprovalFromServer );
                    // Navigator.pop(context);
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
