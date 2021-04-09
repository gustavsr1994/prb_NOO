import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:prb_app/feature/dashboard/companyaddress/companyaddress-page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomerNamePage extends StatefulWidget {
  @override
  _CustomerNamePageState createState() => _CustomerNamePageState();
}

class _CustomerNamePageState extends State<CustomerNamePage>{

  TextEditingController _customerNameController = TextEditingController();
  TextEditingController _brandNameController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _segmenController = TextEditingController();
  TextEditingController _subSegmenController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _companyStausController = TextEditingController();
  TextEditingController _faxController = TextEditingController();
  TextEditingController _contactPersonController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  File _imageKTP;
  File _imageNPWP;
  File _imageSIUP;
  File _imageBuilding;
//  DateTime _date;

  final picker = ImagePicker();

  // getImageKTP
  Future getImageKTP() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageKTP = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // getImageNPWP
  Future getImageNPWP() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageNPWP = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // getImageSIUP
  Future getImageSIUP() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageSIUP = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // getImageBuilding
  Future getImageBuilding() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageBuilding = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //hit api Category
  var urlGetCategory = "http://119.18.157.236:8893/Api/CustCategory";
  String _valCategory;
  List<dynamic> _dataCategory = List();
  void getCategory() async {
    final response = await http.get(Uri.parse(urlGetCategory));
    var listData = jsonDecode(response.body);
    print(urlGetCategory);
    setState((){
      _dataCategory = listData;
      if(!categoryContains(_valCategory)) {
        _valCategory = null;
      }
    });
    print("Data Category : $listData");
  }
  bool categoryContains(String category)  {
    for(int i=0; i<_dataCategory.length; i++){
      if(category==_dataCategory[i]["MASTER_SETUP"]) return true;
    }
    return false;
  }


  //Hit API Dropdown Segmen dan SubSegment
  var urlGetSegment = "http://119.18.157.236:8893/Api/CustSegment";
  var urlGetSubSegment = "http://119.18.157.236:8893/Api/CustSubSegment";
  String _valSegment, _valSubSegment;
  List<dynamic> _dataSegment = List(), _dataSubSegment = List();

  void getSegment() async {
   final response = await http.get(Uri.parse(urlGetSegment)); //untuk melakukan request ke webservice
    var listData = jsonDecode(response.body); //lalu kita decode hasil datanya
   print(urlGetSegment);
   setState(() {
      _dataSegment = listData; // dan kita set kedalam variable _dataProvince
    });
    print("Data Segment : $listData");
  }

  void getSubSegment(String SelectedSegment) async {
    final response = await http.get(Uri.parse(urlGetSubSegment));
    var listData = jsonDecode(response.body);
    print(SelectedSegment);
    setState(() {
//      String SelectedSegment;
//      listData = listData.where((element) => element["SEGMENTID"] == SelectedSegment).toList();
//      SelectedSegment = "Agro";
      listData = listData.where((element) => element["SEGMENTID"] == SelectedSegment).toList();
      _dataSubSegment = listData;
    });
    print("Data SubSegment : $listData");
  }

  //hit api Class
  var urlGetClass = "http://119.18.157.236:8893/Api/CustClass";
  String _valClass;
  List<dynamic> _dataClass = List();
  void getClass() async {
    final response = await http.get(Uri.parse(urlGetClass));
    var listData = jsonDecode(response.body);
    print(urlGetClass);
    setState((){
      _dataClass = listData;
    });
    print("Data Class : $listData");
  }

  //hit api CompanyStatus
  var urlGetCompanyStatus = "http://119.18.157.236:8893/Api/CustCompanyChain";
  String _valCompanyStatus;
  List<dynamic> _dataCompanyStatus = List();

  void getCompanyStatus() async {
    final response = await http.get(Uri.parse(urlGetCompanyStatus));
    var listData = jsonDecode(response.body);
    print(urlGetCompanyStatus);
    setState((){
      _dataCompanyStatus = listData;
    });
    print("Data CompanyStatus : $listData");
  }

  //Proses di submit button
  processSubmitCustomerForm(String customerName, String brandName, String category,
      String segmen, String subSegmen, String selectClass, String phone, String companyStatus,
      String fax, String contactPerson, String emailAddress, String website,) async {

    var urlPostSubmitCustomerForm = "http://192.168.0.13:8893/Api/NOOCustTables";
    print("Ini url Post Submit Customer : $urlPostSubmitCustomerForm");
    var jsonSubmitCustomerForm = await http.post(Uri.parse(
      "$urlPostSubmitCustomerForm",
    ), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
        body: jsonEncode(<String,dynamic>{
      "CustName" : "$customerName",
      "BrandName" : "$brandName",
      "Category" : "$category",
      "Segment" : "$segmen",
      "SubSegment" : "$subSegmen",
      "Class" : "$selectClass",
      "PhoneNo" : "$phone",
      "CompanyStatus" : "$companyStatus",
      "FaxNo" : "$fax",
      "ContactPerson" : "$contactPerson",
      "EmailAddress" : "$emailAddress",
      "NPWP" : "Rachmat NPWP",
      "KTP" : "Rachmat KTP",
      "Currency" : "Rachmat Currency",
      "SalesOffice" : "Rachmat SalesOffice",
      "PriceGroup" : "Rachmat PriceGroup",
      "BusinessUnit" : "Rachmat BusinessUnit",
      "Salesman" : "Rachmat Salesman",
      "Notes" : "Rachmat Notes",
      "Website" : "$website",
      "FotoNPWP" : "Rachmat FotoNPWP",
      "FotoKTP" : "Rachmat FotoKTP",
      "FotoSIUP" : "Rachmat FotoSIUP",
      "FotoGedung" : "Rachmat FotoGedung",
      "CustSignature" : "Rachmat CustSignature",
      "CreatedBy" : 1,
      "CreatedDate" : "2021-04-05T14:56:48.57",
    }));
    print(jsonSubmitCustomerForm.body.toString());
    if (jsonSubmitCustomerForm.statusCode == 200) {
      return jsonDecode(jsonSubmitCustomerForm.body);
    } else {
      throw Exception("Failed");
    }
  }

  @override
  void dispose() async {
    super.dispose();
    var savedForm = jsonEncode(
        <String,dynamic> {
          "CustName" : "${_customerNameController.text}",
          "BrandName" : "${_brandNameController.text}",
          "Category" : "${_valCategory}",
          "Segment" : "${_valSegment}",
          "SubSegment" : "${_valSubSegment}",
          "Class" : "${_valClass}",
          "PhoneNo" : "${_phoneController.text}",
          "CompanyStatus" : "${_valCompanyStatus}",
          "FaxNo" : "${_faxController.text}",
          "ContactPerson" : "${_contactPersonController.text}",
          "EmailAddress" : "${_emailAddressController.text}",
          "NPWP" : "Rachmat NPWP",
          "KTP" : "Rachmat KTP",
          "Currency" : "Rachmat Currency",
          "SalesOffice" : "Rachmat SalesOffice",
          "PriceGroup" : "Rachmat PriceGroup",
          "BusinessUnit" : "Rachmat BusinessUnit",
          "Salesman" : "Rachmat Salesman",
          "Notes" : "Rachmat Notes",
          "Website" : "${_websiteController.text}",
          "FotoNPWP" : "Rachmat FotoNPWP",
          "FotoKTP" : "Rachmat FotoKTP",
          "FotoSIUP" : "Rachmat FotoSIUP",
          "FotoGedung" : "Rachmat FotoGedung",
          "CustSignature" : "Rachmat CustSignature",
          "CreatedBy" : 1,
          "CreatedDate" : "2021-04-05T14:56:48.57",
        }
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("customer", savedForm);
    // TODO: implement dispose
    print("page customer disposed");
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getSegment();
    getCategory();
    getClass();
    getCompanyStatus();
    getDataFromPerf();
  }

  getDataFromPerf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedForm = prefs.getString("customer");
    var savedFormMap = jsonDecode(savedForm);
    print("Ini perfs dari savedFormMap : $savedFormMap");
    _customerNameController.text=savedFormMap["CustName"];
    _brandNameController.text=savedFormMap["BrandName"];
    _valCategory=savedFormMap["Category"];_dataCategory.add(<String, dynamic>{"Category":_valCategory});
//    _valSegment=savedFormMap["Segment"]; _dataSegment.add(<String, dynamic>{"Segment":_valSegment});
//    _valSubSegment=savedFormMap["SubSegment"]; _dataSubSegment.add(<String, dynamic>{"SubSegment":_valSubSegment});
//    _valClass=savedFormMap["Class"];_dataClass.add(<String, dynamic>{"Class":_valClass});
    _phoneController.text=savedFormMap["PhoneNo"];
//    _valCompanyStatus=savedFormMap["CompanyStatus"]; _dataCompanyStatus.add(<String, dynamic>{"CompanyStatus":_valCompanyStatus});
    _faxController.text=savedFormMap["FaxNo"];
    _contactPersonController.text=savedFormMap["ContactPerson"];
    _emailAddressController.text=savedFormMap["EmailAddress"];
    _websiteController.text=savedFormMap["Website"];
  }

  @override
  Widget build(BuildContext context) {

    print("ini customer page");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          "Customer Form",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15),
          children: <Widget>[

            //Customer Name
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Customer Name :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _customerNameController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Customer Name',
                        filled: true,
                        contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

            //Brand Name
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Brand Name        :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _brandNameController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Brand Name',
                        filled: true,
                        contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

            //Category
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Category              :",
                  ),
                ),
                SizedBox(width: 10,),
                DropdownButton(
                  hint: Text("Select Category"),
                  value: _valCategory,
                  items: _dataCategory.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['MASTER_SETUP']),
                      value: item['MASTER_SETUP'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valCategory = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10,),

            //Segmen
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Segmen               :",
                  ),
                ),
                SizedBox(width: 10,),
                DropdownButton(
                  hint: Text("Select Segment"),
                  value: _valSegment,
                  items: _dataSegment.map((item){
                    return DropdownMenuItem(
                      child: Text(item['SEGMENTID']),
                      value: item['SEGMENTID'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      print("haloo cek ini $value");
                      _valSegment = value;
                      _valSubSegment = null;
                    });
                    var SelectedSegment = value;
                    getSubSegment(SelectedSegment);
                  },
                ),
              ],
            ),
            SizedBox(height: 10,),

            //Sub Segmen
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Sub Segmen       :",
                  ),
                ),
                SizedBox(width: 10,),
                DropdownButton(
                  hint: Text("Select SubSegment"),
                  value: _valSubSegment,
                  items: _dataSubSegment.map((item){
                    return DropdownMenuItem(
                      child: Text("${item['SUBSEGMENTID']}"),
                      value: item['SUBSEGMENTID'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      _valSubSegment = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10,),

            //Class
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Class                    :",
                  ),
                ),
                SizedBox(width: 10,),
                DropdownButton(
                  hint: Text("Select Class"),
                  value: _valClass,
                  items: _dataClass.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['CLASS']),
                      value: item['CLASS'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valClass = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10,),

            //Phone
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Phone                  :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Phone',
                        filled: true,
                        contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

            //Company Status
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Company \n Status                 :",
                  ),
                ),
                SizedBox(width: 10,),
                DropdownButton(
                  hint: Text("Select Company Status"),
                  value: _valCompanyStatus,
                  items: _dataCompanyStatus.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['CHAINID']),
                      value: item['CHAINID'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valCompanyStatus = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10,),

            //Fax
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Fax                       :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _faxController,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Fax',
                        filled: true,
                        contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

            //Contact Person
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Contact Person  :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _contactPersonController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Contact Person',
                        filled: true,
                        contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

            //Email Address
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Email Address    :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Email Address',
                        filled: true,
                        contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

            //Website
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Website               :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _websiteController,
                      keyboardType: TextInputType.url,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Website',
                        filled: true,
                        contentPadding: EdgeInsets.all(5),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

            //Attachment label
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Attachment         :",
                  ),
                ),
                SizedBox(width: 10,),
              ],
            ),
            SizedBox(height: 20,),

            //ScrollHorizontal ListView Upload KTP Alt dan Attachment Lainya
            Container(
              height: 120, //Mengubah ukuran tinggi upload ktp
//              width: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [

                  //Upload KTP
                  Card(
                    child: Container(
                      height: 200,
                      width: 150,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 10,),
                              Center(
                                child: _imageKTP == null ? Text(
                                    "KTP"
                                ): Image.file(
                                  _imageKTP,
                                  fit: BoxFit.cover,
//                                  width: 150,
//                                  height: 80,
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                          FloatingActionButton(
                            onPressed: getImageKTP,
                            tooltip: 'Pick Image',
                            child: Icon(Icons.add_a_photo),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),

                  //Upload NPWP
                  Card(
                    child: Container(
                      height: 200,
                      width: 150,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 10,),
                              Center(
                                child: _imageNPWP == null ? Text(
                                    "NPWP"
                                ): Image.file(
                                  _imageNPWP,
                                  fit: BoxFit.cover,
//                                  width: 150,
//                                  height: 80,
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                          FloatingActionButton(
                            onPressed: getImageNPWP,
                            tooltip: 'Pick Image',
                            child: Icon(Icons.add_a_photo),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),

                  //Upload SIUP
                  Card(
                    child: Container(
                      height: 200,
                      width: 150,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 10,),
                              Center(
                                child: _imageSIUP == null ? Text(
                                    "SIUP"
                                ): Image.file(
                                  _imageSIUP,
                                  fit: BoxFit.cover,
//                                  width: 150,
//                                  height: 80,
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                          FloatingActionButton(
                            onPressed: getImageSIUP,
                            tooltip: 'Pick Image',
                            child: Icon(Icons.add_a_photo),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),

                  //Upload BUILDING
                  Card(
                    child: Container(
                      height: 200,
                      width: 150,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 10,),
                              Center(
                                child: _imageBuilding == null ? Text(
                                    "Building"
                                ): Image.file(
                                  _imageBuilding,
                                  fit: BoxFit.cover,
//                                  width: 150,
//                                  height: 80,
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                          FloatingActionButton(
                            onPressed: getImageBuilding,
                            tooltip: 'Pick Image',
                            child: Icon(Icons.add_a_photo),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),

            Center(
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () async {
                  print(_formkey.currentState.validate());
                  if (_formkey.currentState.validate()) {
                    print("Ini proses submit");
                    processSubmitCustomerForm(_customerNameController.text, _brandNameController.text,
                      _valCategory, _valSegment, _valSubSegment, _valClass, _phoneController.text,
                      _valCompanyStatus, _faxController.text, _contactPersonController.text,
                      _emailAddressController.text, _websiteController.text,
                    );
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
    ),
    );
  }
}
