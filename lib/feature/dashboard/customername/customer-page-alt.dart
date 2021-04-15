import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
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

  //hit api Category
  var urlGetCategory = "http://119.18.157.236:8893/Api/CustCategory";
  String _valCategory;
  // ignore: deprecated_member_use
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
  // ignore: deprecated_member_use
  List<dynamic> _dataSegment = List(), _dataSubSegment = List();
  void getSegment() async {
    final response = await http.get(Uri.parse(urlGetSegment)); //untuk melakukan request ke webservice
    var listData = jsonDecode(response.body); //lalu kita decode hasil datanya
    print(urlGetSegment);
    setState(() {
      _dataSegment = listData; // dan kita set kedalam variable _dataProvince
      if(!segmenContains(_valSegment)){
        _valSegment = null;
      }
    });
    print("Data Segment : $listData");
  }
  bool segmenContains(String segmen){
    for (int i=0; i<_dataSegment.length; i++){
      if(segmen==_dataSegment[i]["SEGMENTID"]) return true;
    }
    return false;
  }
  void getSubSegment(String SelectedSegment) async {
    final response = await http.get(Uri.parse(urlGetSubSegment));
    var listData = jsonDecode(response.body);
    print(SelectedSegment);
    setState(() {
      listData = listData.where((element) => element["SEGMENTID"] == SelectedSegment).toList();
      _dataSubSegment = listData;
      print("test $_dataSubSegment");
      print("test $_dataSubSegment filter by $SelectedSegment");
      if(!subsegmenContains(_valSubSegment)){
        _valSubSegment = null;
      }
    });
    print("Data SubSegment : $listData");
  }
  bool subsegmenContains(String subSegmen){
    for (int i=0; i<_dataSubSegment.length; i++){
      if(subSegmen==_dataSubSegment[i]["SUBSEGMENTID"]) return true;
    }
    return false;
  }

  //hit api Class
  var urlGetClass = "http://119.18.157.236:8893/Api/CustClass";
  String _valClass;
  bool _selectedClass = false;
  // ignore: deprecated_member_use
  List<dynamic> _dataClass = List();
  void getClass() async {
    final response = await http.get(Uri.parse(urlGetClass));
    var listData = jsonDecode(response.body);
    print(urlGetClass);
    setState((){
      _dataClass = listData;
      if(!classContains(_valClass)){
        _valClass = null;
      }
    });
    print("Data Class : $listData");
  }
  bool classContains(String classs){
    for (int i=0; i<_dataClass.length; i++){
      if(classs==_dataClass[i]["CLASS"]) return true;
    }
    return false;
  }

  //hit api CompanyStatus
  var urlGetCompanyStatus = "http://119.18.157.236:8893/Api/CustCompanyChain";
  String _valCompanyStatus;
  bool _selectedCompanyStatus = false;
  List<dynamic> _dataCompanyStatus = List();

  void getCompanyStatus() async {
    final response = await http.get(Uri.parse(urlGetCompanyStatus));
    var listData = jsonDecode(response.body);
    print(urlGetCompanyStatus);
    setState((){
      _dataCompanyStatus = listData;
      if(!companyContains(_valCompanyStatus)){
        _valCompanyStatus = null;
      }
    });
    print("Data CompanyStatus : $listData");
  }
  bool companyContains(String company){
    for (int i=0; i<_dataCompanyStatus.length; i++){
      if(company==_dataCompanyStatus[i]["CHAINID"]) return true;
    }
    return false;
  }

  //Proses di submit button
  processSubmitCustomerForm(String category, String segmen, String subSegmen, String selectClass,String companyStatus,) async {
    var urlPostSubmitCustomerForm = "http://192.168.0.13:8893/Api/NOOCustTables";
    print("Ini url Post Submit Customer : $urlPostSubmitCustomerForm");
    var jsonSubmitCustomerForm = await http.post(Uri.parse(
      "$urlPostSubmitCustomerForm",
    ), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
        body: jsonEncode(<String,dynamic>{
          "Category" : "$category",
          "Segment" : "$segmen",
          "SubSegment" : "$subSegmen",
          "Class" : "$selectClass",
          "CompanyStatus" : "$companyStatus",
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
    var mapForm = <String, dynamic>{
      "Category" : "${_valCategory}",
      "Segment" : "${_valSegment}",
      "SubSegment" : "${_valSubSegment}",
      "Class" : "${_valClass}",
      "CompanyStatus" : "${_valCompanyStatus}",
    };
    var savedForm = jsonEncode(mapForm);
    if(_valSegment!=null) {
      mapForm[("Segment")] = _valSegment;
      mapForm[("SubSegment")] = _valSubSegment;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("customer", savedForm);
    // TODO: implement dispose
    print("page customer disposed");
  }

  getDataFromPerf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedForm = prefs.getString("customer");
    var savedFormMap = jsonDecode(savedForm);
    print("Ini perfs dari savedFormMap : $savedFormMap");
    _valCategory=savedFormMap["Category"];_dataCategory.add(<String, dynamic>{"Category":_valCategory});
    _valSegment=savedFormMap["Segment"]; _dataSegment.add(<String, dynamic>{"Segment":_valSegment});
    if(_valSegment != null) {
      await getSubSegment(_valSegment);
      print("test $_dataSubSegment");
      print("test $_valSegment");
      _valSubSegment=savedFormMap["SubSegment"];//_dataSubSegment.add(<String, dynamic>{"SubSegment":_valSubSegment});
    }
    _valClass=savedFormMap["Class"];_dataClass.add(<String, dynamic>{"Class":_valClass});
    _valCompanyStatus=savedFormMap["CompanyStatus"]; _dataCompanyStatus.add(<String, dynamic>{"CompanyStatus":_valCompanyStatus});
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
                      child: Text(item['MASTER_SETUP']??"loading.."),
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
                  value:  _valSegment,
                  items: _dataSegment.map((item){
                    return DropdownMenuItem(
                      child: Text(item['SEGMENTID']??"loading.."),
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
                      child: Text("${item['SUBSEGMENTID']??"loading.."}"),
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
                      child: Text(item['CLASS']??"loading.."),
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
                      child: Text(item['CHAINID']??"loading.."),
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

            //Button Refresh
            Center(
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove("customer");
                },
                child: Text(
                  "Refresh",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            //Button Submit
            Center(
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () async {
                  print(_formkey.currentState.validate());
                  if (_formkey.currentState.validate()) {
                    print("Ini proses submit");
                    processSubmitCustomerForm(
                      _valCategory, _valSegment, _valSubSegment, _valClass,
                      _valCompanyStatus,
                    );
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.getString("company");
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
