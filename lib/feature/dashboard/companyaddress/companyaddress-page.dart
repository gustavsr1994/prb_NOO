import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:location/location.dart';

class CompanyAddressPage extends StatefulWidget {
  @override
  _CompanyAddressPageState createState() => _CompanyAddressPageState();
}

class _CompanyAddressPageState extends State<CompanyAddressPage> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _salesmanController = TextEditingController();
  TextEditingController _salesOfficeController = TextEditingController();
  TextEditingController _businessUnitController = TextEditingController();
  TextEditingController _npwpController = TextEditingController();
  TextEditingController _ktpController = TextEditingController();
  TextEditingController _currencyController = TextEditingController();
  TextEditingController _priceGroupController = TextEditingController();


  final _formkey = GlobalKey<FormState>();

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

  processSubmitCompanyForm(String name, String streetname, String city,
      String country, String state, String zipcode, String salesman, String salesoffice,
      String businessunit, String npwp, String ktp, String pricegroup, String currency) async {
    var urlPostSubmitCompanyForm = "http://192.168.0.13:8893/Api/NOOCustTables";
    print("Ini url Post Submit Company : $urlPostSubmitCompanyForm");
    var jsonSubmitCompanyForm = await http.post(Uri.parse(
      "$urlPostSubmitCompanyForm",
    ), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
        body: jsonEncode(<String,dynamic>{
          "Name" : "$name",
          "StreetName" : "$streetname",
          "City" : "$city",
          "Country" : "$country",
          "State" : "$state",
          "ZipCode" : "$zipcode",
          "Salesman" : "$salesman",
          "SalesOffice" : "$salesoffice",
          "BusinessUnit" : "$businessunit",
          "NPWP" : "$npwp",
          "KTP" : "$ktp",
          "PriceGroup" : "$pricegroup",
          "Currency" : "$currency",
        }));
    print(jsonSubmitCompanyForm.body.toString());
    if (jsonSubmitCompanyForm.statusCode == 200) {
      return jsonDecode(jsonSubmitCompanyForm.body);
    } else {
      throw Exception("Failed");
    }
  }

  void dispose() async {
    super.dispose();
    var mapForm = <String, dynamic>{
      "Name" : "${_nameController.text}",
      "StreetName" : "${_streetController.text}",
      "City" : "${_cityController.text}",
      "Country" : "${_countryController.text}",
      "State" : "${_stateController.text}",
      "ZipCode" : "${_zipCodeController.text}",
      "Salesman" : "${_salesmanController.text}",
      "SalesOffice" : "${_salesOfficeController.text}",
      "BusinerssUnit" : "${_businessUnitController.text}",
      "NPWP" : "${_npwpController.text}",
      "KTP" : "${_ktpController.text}",
      "PriceGroup" : "$_valPriceGroup",
      "Currency" : "${_currencyController.text}",
    };
    var savedForm = jsonEncode(mapForm);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("company", savedForm);
    // TODO: implement dispose
    print("page company disposed");
  }

  getDataFromPerf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedForm = prefs.getString("company");
    var savedFormMap = jsonDecode(savedForm);
    print("Ini perfs dari savedFormMap : $savedFormMap");
    _nameController.text=savedFormMap["Name"];
    _streetController.text=savedFormMap["StreetName"];
    _cityController.text=savedFormMap["City"];
    _countryController.text=savedFormMap["Country"];
    _stateController.text=savedFormMap["State"];
    _zipCodeController.text=savedFormMap["ZipCode"];
    _salesmanController.text=savedFormMap["Salesman"];
    _salesOfficeController.text=savedFormMap["SalesOffice"];
    _businessUnitController.text=savedFormMap["BusinessUnit"];
    _npwpController.text=savedFormMap["NPWP"];
    _ktpController.text=savedFormMap["KTP"];
    _valPriceGroup=savedFormMap["PriceGroup"];_dataPriceGroup.add(<String, dynamic>{"PriceGroup":_valPriceGroup});
    _currencyController.text=savedFormMap["Currency"];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPriceGroup();
    getDataFromPerf();
  }

  @override
  Widget build(BuildContext context) {

    print("ini company page");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          "Company Form",
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

            SizedBox(height: 20,),

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
                      controller: _nameController,
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
                      controller: _streetController,
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
                      controller: _cityController,
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
                      controller: _countryController,
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
                      controller: _stateController,
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
                      controller: _zipCodeController,
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

            //Salesman
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Salesman            :",
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _salesmanController,
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
                      controller: _salesOfficeController,
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
                      controller: _businessUnitController,
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
                      controller: _npwpController,
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
                      controller: _ktpController,
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
                      controller: _currencyController,
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
          ],
        ),
      ),
    );
  }
}
