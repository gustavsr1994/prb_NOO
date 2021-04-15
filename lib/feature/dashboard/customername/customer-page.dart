import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage>{

  //Customer Controller
  TextEditingController _customerNameControllerCustomer = TextEditingController();
  TextEditingController _brandNameControllerCustomer = TextEditingController();
  TextEditingController _categoryControllerCustomer = TextEditingController();
  TextEditingController _segmenControllerCustomer = TextEditingController();
  TextEditingController _subSegmenControllerCustomer = TextEditingController();
  TextEditingController _classControllerCustomer = TextEditingController();
  TextEditingController _phoneControllerCustomer = TextEditingController();
  TextEditingController _companyStausControllerCustomer = TextEditingController();
  TextEditingController _faxControllerCustomer = TextEditingController();
  TextEditingController _contactPersonControllerCustomer = TextEditingController();
  TextEditingController _emailAddressControllerCustomer = TextEditingController();
  TextEditingController _npwpControllerCustomer = TextEditingController();
  TextEditingController _ktpControllerCustomer = TextEditingController();
  TextEditingController _currencyControllerCustomer = TextEditingController();
  TextEditingController _salesOfficeControllerCustomer = TextEditingController();
  TextEditingController _priceGroupControllerCustomer = TextEditingController();
  TextEditingController _businessUnitControllerCustomer = TextEditingController();
  TextEditingController _salesmanControllerCustomer = TextEditingController();
  TextEditingController _websiteControllerCustomer = TextEditingController();
  TextEditingController _fotoktpControllerCustomer = TextEditingController();
  TextEditingController _fotonpwpControllerCustomer = TextEditingController();
  TextEditingController _fotosiupControllerCustomer = TextEditingController();
  TextEditingController _fotobuildingControllerCustomer = TextEditingController();

  //Company Controller
  TextEditingController _nameControllerCompany = TextEditingController();
  TextEditingController _streetControllerCompany = TextEditingController();
  TextEditingController _cityControllerCompany = TextEditingController();
  TextEditingController _countryControllerCompany = TextEditingController();
  TextEditingController _stateControllerCompany = TextEditingController();
  TextEditingController _zipCodeControllerCompany = TextEditingController();

  //Tax Controller
  TextEditingController _nameControllerTax = TextEditingController();
  TextEditingController _streetControllerTax = TextEditingController();
  TextEditingController _cityControllerTax = TextEditingController();
  TextEditingController _countryControllerTax = TextEditingController();
  TextEditingController _stateControllerTax = TextEditingController();
  TextEditingController _zipCodeControllerTax = TextEditingController();

  //Delivery Controller
  TextEditingController _nameControllerDelivery = TextEditingController();
  TextEditingController _streetControllerDelivery = TextEditingController();
  TextEditingController _cityControllerDelivery = TextEditingController();
  TextEditingController _countryControllerDelivery = TextEditingController();
  TextEditingController _stateControllerDelivery = TextEditingController();
  TextEditingController _zipCodeControllerDelivery = TextEditingController();

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

  //hit api PriceGroup
  var urlGetPriceGroup = "http://119.18.157.236:8893/Api/CustPriceGroup";
  String _valPriceGroup;
  // ignore: deprecated_member_use
  List<dynamic> _dataPriceGroup = List();
  void getPriceGroup() async {
    final response = await http.get(Uri.parse(urlGetPriceGroup));
    var listData = jsonDecode(response.body);
    print(urlGetPriceGroup);
    setState((){
      _dataPriceGroup = listData;
      if(!pricegroupContains(_valPriceGroup)){
        _valPriceGroup = null;
      }
    });
    print("Data CompanyStatus : $listData");
  }
  bool pricegroupContains(String pricegroup){
    for(int i = 0; i<_dataPriceGroup.length; i++){
      if(pricegroup==_dataPriceGroup[i]["NAME"]) return true;
    }
    return false;
  }

  //Proses di submit button
  processSubmitCustomerForm(
      //Customer
      String customerNameCustomer, String brandNameCustomer, String categoryCustomer,
      String segmenCustomer, String subSegmenCustomer, String selectClassCustomer, String phoneCustomer,
      String companyStatusCustomer, String faxCustomer, String contactPersonCustomer, String emailAddressCustomer,
      String npwpCustomer, String ktpCustomer, String currencyCustomer, String salesofficeCustomer, String pricegroupCustomer,
      String businessunitCustomer, String salesmanCustomer, String websiteCustomer,

      //Company
      String nameCompany, String streetnameCompany, String cityCompany, String countryCompany,
      String stateCompany, String zipcodeCompany,

      //Tax
      String nameTax, String streetNameTax, String cityTax, String countryTax,
      String stateTax, String zipcodeTax,

      //Delivery
      String nameDelivery, String streetNameDelivery, String cityDelivery, String countryDelivery,
      String stateDelivery, String zipcodeDelivery,

      ) async {
    var urlPostSubmitCustomerForm = "http://192.168.0.13:8893/Api/NOOCustTables";
    print("Ini url Post Submit Customer : $urlPostSubmitCustomerForm");
    var jsonSubmitCustomerForm = await http.post(Uri.parse(
      "$urlPostSubmitCustomerForm",
    ), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
        body: jsonEncode(<String,dynamic>{
        "CustName" : "$customerNameCustomer",
        "BrandName" : "$brandNameCustomer",
        "Category" : "$categoryCustomer",
        "Segment" : "$segmenCustomer",
        "SubSegment" : "$subSegmenCustomer",
        "Class" : "$selectClassCustomer",
        "PhoneNo" : "$phoneCustomer",
        "CompanyStatus" : "$companyStatusCustomer",
        "FaxNo" : "$faxCustomer",
        "ContactPerson" : "$contactPersonCustomer",
        "EmailAddress" : "$emailAddressCustomer",
        "NPWP" : "$npwpCustomer",
        "KTP" : "$ktpCustomer",
        "Currency" : "$currencyCustomer",
        "SalesOffice" : "$salesofficeCustomer",
        "PriceGroup" : "$pricegroupCustomer",
        "BusinessUnit" : "$businessunitCustomer",
        "Salesman" : "$salesmanCustomer",
        "Notes" : "Rachmat Notes",
        "Website" : "$websiteCustomer",
        "FotoNPWP" : "Rachmat FotoNPWP",
        "FotoKTP" : "Rachmat FotoKTP",
        "FotoSIUP" : "Rachmat FotoSIUP",
        "FotoGedung" : "Rachmat FotoGedung",
        "CustSignature" : "Rachmat CustSignature",
        "CreatedBy" : 1,
        "CreatedDate" : "2021-04-05T14:56:48.57",
        "TaxAddresses":[{
        "Name" : "$nameTax",
        "StreetName" : "$streetNameTax",
        "City" : "$cityTax",
        "Country" : "$countryTax",
        "State" : "$stateTax",
        "ZipCode" : "$zipcodeTax"
        }],
        "CompanyAddresses":[{
        "Name" : "$nameCompany",
        "StreetName" : "$streetnameCompany",
        "City" : "$cityCompany",
        "Country" : "$countryCompany",
        "State" : "$stateCompany",
        "ZipCode" : "$zipcodeCompany"
        }],
        "DeliveryAddresses":[{
        "Name" : "$nameDelivery",
        "StreetName" : "$streetNameDelivery",
        "City" : "$cityDelivery",
        "Country" : "$countryDelivery",
        "State" : "$stateDelivery",
        "ZipCode" : "$zipcodeDelivery"
    }]}));
    print(jsonSubmitCustomerForm.body.toString());
    if (jsonSubmitCustomerForm.statusCode == 200) {
      return jsonDecode(jsonSubmitCustomerForm.body);
    } else {
      throw Exception("Failed");
    }
  }


  void initState() {
    // TODO: implement initState
    super.initState();
    getSegment();
    getCategory();
    getClass();
    getPriceGroup();
    getCompanyStatus();
//    getDataFromPerf();
  }

  @override
  Widget build(BuildContext context) {

    print("ini customer page");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          "NOO Form",
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

            Center(
              child: Text(
                "Customer Form",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ),

            SizedBox(height: 20,),

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
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _customerNameControllerCustomer,
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
                      controller: _brandNameControllerCustomer,
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
                      controller: _phoneControllerCustomer,
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
                      controller: _faxControllerCustomer,
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
                      controller: _contactPersonControllerCustomer,
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
                      controller: _emailAddressControllerCustomer,
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

            //NPWP
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "NPWP                   :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _npwpControllerCustomer,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'NPWP',
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

            //KTP
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "KTP                       :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _ktpControllerCustomer,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'KTP',
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

            //Currency
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Currency              :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _currencyControllerCustomer,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Currency',
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

            //Sales Office
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Sales Office         :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _salesOfficeControllerCustomer,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Sales Office',
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

            //Price Group
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Price Group         :",
                  ),
                ),
                SizedBox(width: 10,),
                DropdownButton(
                  hint: Text("Select PriceGroup"),
                  value: _valPriceGroup,
                  items: _dataPriceGroup.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['NAME']??"loading.."),
                      value: item['NAME'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valPriceGroup = value;
//                      this._salutationPriceGroup = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10,),

            //Business Unit
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Business Unit      :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _businessUnitControllerCustomer,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Business Unit',
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

            //Salesman
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Salesman             :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _salesmanControllerCustomer,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Salesman',
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
                    "Website                :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _websiteControllerCustomer,
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
                    "Attachment          :",
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

            Divider(
              color: Colors.black,
              height:0,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),

            SizedBox(height: 20,),

            //Label Company Form
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

            //Company Widget
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Name                    :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _nameControllerCompany,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Name',
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

                //Street Name
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Street Name        :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _streetControllerCompany,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Street Name',
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

                //City
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "City                        :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _cityControllerCompany,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'city',
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

                //Country
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Country                :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _countryControllerCompany,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Country',
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

                //State
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "State                     :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _stateControllerCompany,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'State',
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

                //ZIP Code
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "ZIP Code              :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _zipCodeControllerCompany,
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'ZIP Code',
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

              ],
            ),

            SizedBox(height: 20,),

            Divider(
              color: Colors.black,
              height:0,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),

            SizedBox(height: 20,),

            //Label Tax Form
            Center(
              child: Text(
                "Tax Address",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ),

            SizedBox(height: 20,),

            //Tax Widget
            Column(
              children: [
                //Name
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Name                    :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _nameControllerTax,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Name',
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

                //Street Name
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Street Name        :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _streetControllerTax,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Street Name',
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

                //City
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "City                        :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _cityControllerTax,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'city',
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

                //Country
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Country                :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _countryControllerTax,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Country',
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

                //State
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "State                     :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _stateControllerTax,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'State',
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

                //ZIP Code
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "ZIP Code              :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _zipCodeControllerTax,
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'ZIP Code',
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

              ],
            ),

            SizedBox(height: 20,),

            Divider(
              color: Colors.black,
              height:0,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),

            SizedBox(height: 20,),

            //Label Delivery Form
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

            //Delivery Widget
            Column(
              children: [
                //Name
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Name                    :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _nameControllerDelivery,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Name',
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

                //Street Name
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Street Name        :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _streetControllerDelivery,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Street Name',
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

                //City
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "City                        :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _cityControllerDelivery,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'city',
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

                //Country
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Country                :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _countryControllerDelivery,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Country',
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

                //State
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "State                     :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _stateControllerDelivery,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'State',
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

                //ZIP Code
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "ZIP Code              :",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _zipCodeControllerDelivery,
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'ZIP Code',
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

              ],
            ),

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
                      //Customer
                      _customerNameControllerCustomer.text, _brandNameControllerCustomer.text,
                      _valCategory, _valSegment, _valSubSegment, _valClass, _phoneControllerCustomer.text,
                      _valCompanyStatus, _faxControllerCustomer.text, _contactPersonControllerCustomer.text,
                      _emailAddressControllerCustomer.text, _npwpControllerCustomer.text, _ktpControllerCustomer.text,
                      _currencyControllerCustomer.text, _salesOfficeControllerCustomer.text, _valPriceGroup,
                      _businessUnitControllerCustomer.text, _salesmanControllerCustomer.text, _websiteControllerCustomer.text,
                      
                      //Company
                      _nameControllerCompany.text, _streetControllerCompany.text, _cityControllerCompany.text,
                      _countryControllerCompany.text, _stateControllerCompany.text, _zipCodeControllerCompany.text,

                      //Tax
                      _nameControllerTax.text, _streetControllerTax.text, _cityControllerTax.text,
                      _countryControllerTax.text, _stateControllerTax.text, _zipCodeControllerTax.text,

                      //Delivery
                      _nameControllerDelivery.text, _streetControllerDelivery.text, _cityControllerDelivery.text,
                      _countryControllerDelivery.text, _stateControllerDelivery.text, _zipCodeControllerDelivery.text,
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
