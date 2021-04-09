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
  List<dynamic> _dataPriceGroup = List();
  void getPriceGroup() async {
    final response = await http.get(Uri.parse(urlGetPriceGroup));
    var listData = jsonDecode(response.body);
    print(urlGetPriceGroup);
    setState((){
      _dataPriceGroup = listData;
    });
    print("Data CompanyStatus : $listData");
  }

  processSubmitCompanyForm(String customerName, String brandName, String category,
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

  void dispose() async {
    super.dispose();
    var savedForm = jsonEncode(
        <String,dynamic> {
          "Name" : "Rachmat Address",
          "StreetName" : "Rachmat StreetName",
          "City" : "Rachmat City",
          "Country" : "Rachmat Country",
          "State" : "Rachmat State",
          "ZipCode" : "11850"
        }
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("customer", savedForm);
    // TODO: implement dispose
    print("page customer disposed");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPriceGroup();
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
                      child: Text(item['NAME']),
                      value: item['NAME'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valPriceGroup = value;
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
