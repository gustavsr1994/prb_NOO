import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TaxAddressPage extends StatefulWidget {
  @override
  _TaxAddressPageState createState() => _TaxAddressPageState();
}

class _TaxAddressPageState extends State<TaxAddressPage> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  processSubmitTaxForm(String name, String streetname, String city,
      String country, String state, String zipcode) async {
    var urlPostSubmitTaxForm = "http://192.168.0.13:8893/Api/NOOCustTables";
    print("Ini url Post Submit Tax : $urlPostSubmitTaxForm");
    var jsonSubmitTaxForm = await http.post(Uri.parse(
      "$urlPostSubmitTaxForm",
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
        }));
    print(jsonSubmitTaxForm.body.toString());
    if (jsonSubmitTaxForm.statusCode == 200) {
      return jsonDecode(jsonSubmitTaxForm.body);
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
    };
    var savedForm = jsonEncode(mapForm);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tax", savedForm);
    // TODO: implement dispose
    print("page tax disposed");
  }

  getDataFromPerf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedForm = prefs.getString("tax");
    var savedFormMap = jsonDecode(savedForm);
    print("Ini perfs dari savedFormMap : $savedFormMap");
    _nameController.text=savedFormMap["Name"];
    _streetController.text=savedFormMap["StreetName"];
    _cityController.text=savedFormMap["City"];
    _countryController.text=savedFormMap["Country"];
    _stateController.text=savedFormMap["State"];
    _zipCodeController.text=savedFormMap["ZipCode"];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromPerf();
  }

  @override
  Widget build(BuildContext context) {

    print("ini tax page");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          "Tax Form",
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
          ],
        ),
      ),
    );
  }
}
