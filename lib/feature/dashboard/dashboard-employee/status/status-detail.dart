import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prb_app/base/base-url.dart';
import 'package:prb_app/feature/dashboard/dashboard-employee/status/status-edit-page.dart';
import 'package:prb_app/model/address.dart';
import 'package:prb_app/model/status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart';
import 'package:transparent_image/transparent_image.dart';

class StatusDetailPage extends StatefulWidget {
  int id;
  String userid;
  String so;
  String bu;
  String name;

  StatusDetailPage({
    Key key,
    this.id,
    this.userid,
    this.bu,
    this.so,
    this.name,
  });

  @override
  _StatusDetailPageState createState() => _StatusDetailPageState();
}

class _StatusDetailPageState extends State<StatusDetailPage> {
  Status data = new Status();
  Address dataCompanyAddress = new Address();
  Address dataDeliveryAddress = new Address();
  Address dataTAXAddress = new Address();
  String statusApproval;
  String statusRejected = "Rejected";
  String statusDataApprovalDetail;

  Widget _buttonIconEdit() {
    return statusApproval == statusRejected
        ? InkWell(
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StatusEditPage(
                      //Customer form
                      username: widget.name,
                      so: widget.so,
                      bu: widget.bu,
                      userid: widget.userid,
                      id: widget.id,
                      custName: data.custName,
                      brandName: data.brandName,
                      category: data.category,
                      distributionChannels: data.segment,
                      channelSegmentation: data.subSegment,
                      selectClass: data.selectclass,
                      phoneNo: data.phoneNo,
                      companyStatus: data.companyStatus,
                      faxNo: data.faxNo,
                      contactPerson: data.contactPerson,
                      emailAddress: data.emailAddress,
                      website: data.website,
                      npwp: data.nPWP,
                      ktp: data.kTP,
                      siup: data.siup,
                      sppkp: data.sppkp,
                      currency: data.currency,
                      priceGroup: data.priceGroup,
                      salesman: data.salesman,
                      salesOffice: data.salesOffice,
                      businessUnit: data.businessUnit,

                      //Company Address
                      companyID: dataCompanyAddress.id,
                      companyName: dataCompanyAddress.name,
                      companyStreetName: dataCompanyAddress.streetName,
                      companyCity: dataCompanyAddress.city,
                      companyState: dataCompanyAddress.state,
                      companyCountry: dataCompanyAddress.country,
                      companyZipCode: dataCompanyAddress.zipCode.toString(),
                      companyParentID: dataCompanyAddress.parentId,

                      //tax address
                      taxID: dataTAXAddress.id,
                      taxName: dataTAXAddress.name,
                      taxStreetName: dataTAXAddress.streetName,
                      taxCity: dataTAXAddress.city,
                      taxState: dataTAXAddress.state,
                      taxCountry: dataTAXAddress.country,
                      taxZipCode: dataTAXAddress.zipCode.toString(),
                      taxParentID: dataTAXAddress.parentId,

                      //delivery address
                      deliveryID: dataDeliveryAddress.id,
                      deliveryName: dataDeliveryAddress.name,
                      deliveryStreetName: dataDeliveryAddress.streetName,
                      deliveryCity: dataDeliveryAddress.city,
                      deliveryState: dataDeliveryAddress.state,
                      deliveryCountry: dataDeliveryAddress.country,
                      deliveryZipCode:
                      dataDeliveryAddress.zipCode.toString(),
                      autoLatitudeData: data.lat,
                      autoLongitudeData: data.long,
                      deliveryParentID: dataDeliveryAddress.parentId,

                      //attachment
                      fotoktp: data.fotoKTP,
                      fotonpwp: data.fotoNPWP,
                      fotonib: data.fotoSIUP,
                      fotosppkp: data.fotoGedung3,
                      fotofrontview: data.fotoGedung1,
                      fotoinsideview: data.fotoGedung2,
                      fotocustsignature: data.custSignature,
                    )),
          );
        })
        : Container();
  }

  void getStatusDetail() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    var urlGetApprovalDetail = baseURL+"NOOCustTables/" + widget.id.toString();
    Response r = await http.get(Uri.parse(urlGetApprovalDetail), headers: <String, String>{'authorization': basicAuth});
    var dataApprovalDetail = json.decode(r.body);
    statusDataApprovalDetail = dataApprovalDetail["Status"].toString();
    print("Yes yes3: ${dataApprovalDetail["Status"]}");
    print(r.statusCode);
    print(r.body);
    final listData = json.decode(r.body);
    var DataCompany = (listData as Map<String, dynamic>)["CompanyAddresses"];
    var DataDelivery = (listData as Map<String, dynamic>)["DeliveryAddresses"];
    var DataTAX = (listData as Map<String, dynamic>)["TaxAddresses"];
    print(urlGetApprovalDetail);
    setState(() {
      data = Status.fromJson(listData);
      statusApproval = statusDataApprovalDetail;
      print("Yes 3x : $statusApproval");
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

  List listdataApprovalStatus = [];
  Future<String> getDataApprovalStatus() async {
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    var urlGetApprovalStatus = baseURL+"Approval/"+widget.id.toString();
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
    getDataApprovalStatus();
  }

  @override
  Widget build(BuildContext context) {
    print("ini approval detail");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Status Detail",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            _buttonIconEdit(),
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        children: [
          //customer name
          Row(
            children: [
              Text(
                "Customer Name     :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.custName ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //Brand name
          Row(
            children: [
              Text(
                "Brand Name            :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.brandName ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //sales office
          Row(
            children: [
              Text(
                "Sales Office             :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.salesOffice ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //business unit
          Row(
            children: [
              Text(
                "Business Unit          :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.businessUnit ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //category
          Row(
            children: [
              Text(
                "Category                  :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.category ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //distribution channel
          Row(
            children: [
              Text(
                "Distribution\nChannels                 ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  ":     ${data.segment}" ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //channel segmentation
          Row(
            children: [
              Text(
                "Channel\nSegmentation         ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  ":     ${data.subSegment}" ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //class
          Row(
            children: [
              Text(
                "Class                        :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.selectclass ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //company status
          Row(
            children: [
              Text(
                "Company Status     :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.companyStatus ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //currency
          Row(
            children: [
              Text(
                "Currency                   :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.currency ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //price group
          Row(
            children: [
              Text(
                "Price Group              :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.priceGroup ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //contact person
          Row(
            children: [
              Text(
                "Contact Person       :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.contactPerson ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //ktp
          Row(
            children: [
              Text(
                "KTP                           :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.kTP ?? "",
                  style: TextStyle(fontSize: 17, color: Colors.black54),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //npwp
          Row(
            children: [
              Text(
                "NPWP                       :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.nPWP ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          // //siup
          // Row(
          //   children: [
          //     Text(
          //       "SIUP                          :     ",
          //       style: TextStyle(
          //         fontSize: 17,
          //       ),
          //     ),
          //     Flexible(
          //       child: Text(
          //         data.siup ?? "",
          //         style: TextStyle(fontSize: 17, color: Colors.black54),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // //sppkp
          // Row(
          //   children: [
          //     Text(
          //       "SPPKP                      :     ",
          //       style: TextStyle(
          //         fontSize: 17,
          //       ),
          //     ),
          //     Flexible(
          //       child: Text(
          //         data.sppkp ?? "",
          //         style: TextStyle(
          //           fontSize: 17,
          //           color: Colors.black54,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          //phone no
          Row(
            children: [
              Text(
                "Phone No                 :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.phoneNo ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //fax no
          Row(
            children: [
              Text(
                "Fax No                      :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.faxNo ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //email address
          Row(
            children: [
              Text(
                "Email Address         :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.emailAddress ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //website
          Row(
            children: [
              Text(
                "Website                    :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.website ?? "",
                  style: TextStyle(fontSize: 17, color: Colors.black54),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //salesman
          Row(
            children: [
              Text(
                "Salesman                 :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  data.salesman ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
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
          SizedBox(
            height: 10,
          ),

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
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Name                        :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataCompanyAddress.name ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
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
                "Street Name            :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataCompanyAddress.streetName ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
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
                "City                            :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataCompanyAddress.city ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //widget state
          Row(
            children: [
              Text(
                "State                         :      ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataCompanyAddress.state ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //widget country
          Row(
            children: [
              Text(
                "Country                    :      ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataCompanyAddress.country ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
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
                "ZIP Code                  :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataCompanyAddress.zipCode.toString(),
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
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
          SizedBox(
            height: 10,
          ),

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
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Name                        :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataTAXAddress.name ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
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
                "Street Name            :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataTAXAddress.streetName ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
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
                "City                            :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataTAXAddress.city ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //widget state
          Row(
            children: [
              Text(
                "State                          :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataTAXAddress.state ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //widget country
          Row(
            children: [
              Text(
                "Country                     :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataTAXAddress.country ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
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
                "ZIP Code                   :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataTAXAddress.zipCode.toString(),
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
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
          SizedBox(
            height: 10,
          ),

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
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Name                        :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataDeliveryAddress.name ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
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
                "Street Name            :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataDeliveryAddress.streetName ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
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
                "City                            :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataDeliveryAddress.city ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //widget state
          Row(
            children: [
              Text(
                "State                          :   ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataDeliveryAddress.state ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //widget country
          Row(
            children: [
              Text(
                "Country                     :    ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataDeliveryAddress.country ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
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
                "ZIP Code                   :   ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Text(
                  dataDeliveryAddress.zipCode.toString(),
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
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
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          //foto ktp
          Row(
            children: [
              Text(
                "Foto KTP                 :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Container(
                  height: 100,
                  child:
                  // data.fotoKTP != null ? Container():
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) =>
                            Image.network(
                              baseURL+"Files/GetFiles?fileName=${data
                                  .fotoKTP}",
                              filterQuality: FilterQuality.medium,
                              cacheHeight: 400,
                              cacheWidth: 300,
                            ),
                      );
                    },
                    child: Image.network(
                      baseURL+"Files/GetFiles?fileName=${data.fotoKTP}",
                      filterQuality: FilterQuality.low,
                      cacheHeight: 400,
                      cacheWidth: 300,
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
          //foto npwp
          Row(
            children: [
              Text(
                "Foto NPWP             :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Container(
                    height: 100,
                    // child: data.fotoNPWP != null ? Container() : "null" == data.fotoNPWP ? Container():
                    child: InkWell(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (_) =>
                              Image.network(
                                baseURL+"Files/GetFiles?fileName=${data
                                    .fotoNPWP}",
                                filterQuality: FilterQuality.medium,
                                cacheHeight: 400,
                                cacheWidth: 300,
                              ),
                        );
                      },
                      child: Image.network(
                        baseURL+"Files/GetFiles?fileName=${data
                            .fotoNPWP}",
                        filterQuality: FilterQuality.low,
                        cacheHeight: 400,
                        cacheWidth: 300,
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
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //foto siup
          Row(
            children: [
              Text(
                "Foto SIUP               :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Container(
                  height: 100,
                  child:
                  // data.fotoSIUP != null ? Container():
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) =>
                            Image.network(
                              baseURL+"Files/GetFiles?fileName=${data
                                  .fotoSIUP}",
                              filterQuality: FilterQuality.medium,
                              cacheHeight: 400,
                              cacheWidth: 300,
                            ),
                      );
                    },
                    child: Image.network(
                      baseURL+"Files/GetFiles?fileName=${data
                          .fotoSIUP}",
                      filterQuality: FilterQuality.low,
                      cacheHeight: 400,
                      cacheWidth: 300,
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
          //widget foto SPPKP
          Row(
            children: [
              Text(
                "Foto SPPKP          :      ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Container(
                  height: 100,
                  child:
                  // data.fotoGedung != null ? Container():
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) =>
                            Image.network(
                              baseURL+"Files/GetFiles?fileName=${data
                                  .fotoGedung3}",
                              filterQuality: FilterQuality.medium,
                              cacheHeight: 400,
                              cacheWidth: 300,
                            ),
                      );
                    },
                    child: Image.network(
                      baseURL+"Files/GetFiles?fileName=${data
                          .fotoGedung3}",
                      filterQuality: FilterQuality.low,
                      cacheHeight: 400,
                      cacheWidth: 300,
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
          //widget foto gedung depan
          Row(
            children: [
              Text(
                "Foto Gedung\nDepan                    :      ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Container(
                  height: 100,
                  child:
                  // data.fotoGedung != null ? Container():
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) =>
                            Image.network(
                              baseURL+"Files/GetFiles?fileName=${data
                                  .fotoGedung1}",
                              filterQuality: FilterQuality.medium,
                              cacheHeight: 400,
                              cacheWidth: 300,
                            ),
                      );
                    },
                    child: Image.network(
                      baseURL+"Files/GetFiles?fileName=${data
                          .fotoGedung1}",
                      filterQuality: FilterQuality.low,
                      cacheHeight: 400,
                      cacheWidth: 300,
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
          //widget foto gedung dalam
          Row(
            children: [
              Text(
                "Foto Gedung\nDalam                   :       ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: Container(
                  height: 100,
                  child:
                  // data.fotoGedung != null ? Container():
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) =>
                            Image.network(
                              baseURL+"Files/GetFiles?fileName=${data
                                  .fotoGedung2}",
                              filterQuality: FilterQuality.medium,
                              cacheHeight: 400,
                              cacheWidth: 300,
                            ),
                      );
                    },
                    child: Image.network(
                      baseURL+"Files/GetFiles?fileName=${data
                          .fotoGedung2}",
                      filterQuality: FilterQuality.low,
                      cacheHeight: 400,
                      cacheWidth: 300,
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
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Customer\nSignature  ",
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
                        builder: (_) =>
                            Image.network(
                              baseURL+"Files/GetFiles?fileName=${data
                                  .custSignature}",
                              filterQuality: FilterQuality.medium,
                              cacheHeight: 400,
                              cacheWidth: 300,
                            ),
                      );
                    },
                    child: Image.network(
                      baseURL+"Files/GetFiles?fileName=${data.custSignature}",
                      filterQuality: FilterQuality.low,
                      cacheHeight: 400,
                      cacheWidth: 300,
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
                "Sales\nSignature  ",
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
                        builder: (_) =>
                            Image.network(
                              baseURL+"Files/GetFiles?fileName=${data
                                  .salesSignature}",
                              filterQuality: FilterQuality.medium,
                              cacheHeight: 400,
                              cacheWidth: 300,
                            ),
                      );
                    },
                    child: Image.network(
                      baseURL+"Files/GetFiles?fileName=${data
                          .salesSignature}",
                      filterQuality: FilterQuality.low,
                      cacheHeight: 400,
                      cacheWidth: 300,
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
                        builder: (_) =>
                            Image.network(
                              baseURL+"Files/GetFiles?fileName=${data.approval1Signature}",
                              filterQuality: FilterQuality.medium,
                              cacheHeight: 400,
                              cacheWidth: 300,
                            ),
                      );
                    },
                    child: Image.network(
                      baseURL+"Files/GetFiles?fileName=${data.approval1Signature}",
                      filterQuality: FilterQuality.low,
                      cacheHeight: 400,
                      cacheWidth: 300,
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
                        builder: (_) =>
                            Image.network(
                              baseURL+"Files/GetFiles?fileName=${data
                                  .approval2Signature}",
                              filterQuality: FilterQuality.medium,
                              cacheHeight: 400,
                              cacheWidth: 300,
                            ),
                      );
                    },
                    child: Image.network(
                      baseURL+"Files/GetFiles?fileName=${data
                          .approval2Signature}",
                      filterQuality: FilterQuality.low,
                      cacheHeight: 400,
                      cacheWidth: 300,
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
                "Approval 3\nSignature",
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
                        builder: (_) =>
                            Image.network(
                              baseURL+"Files/GetFiles?fileName=${data
                                  .approval3Signature}",
                              filterQuality: FilterQuality.medium,
                              cacheHeight: 400,
                              cacheWidth: 300,
                            ),
                      );
                    },
                    child: Image.network(
                      baseURL+"Files/GetFiles?fileName=${data
                          .approval3Signature}",
                      filterQuality: FilterQuality.low,
                      cacheHeight: 400,
                      cacheWidth: 300,
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
                "Remark                     :     ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Flexible(
                child: AutoSizeText(
                  data.remark ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
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
                "Status",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(98, 0, 20, 0),
                child: Text(":"),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context, builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        height: 250,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("Status Approval Detail"),
                                Container(
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
                child: Text(
                  data.status ?? "",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
