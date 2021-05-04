//import 'dart:convert';
//import 'package:http/http.dart' as http;
//
//class CustomerPresenter {
//
//
//  //hit api Category
//  var urlGetCategory = "http://119.18.157.236:8893/Api/CustCategory";
//  String _valCategory;
//  List<dynamic> _dataCategory = List();
//  void getCategory() async {
//    final response = await http.get(Uri.parse(urlGetCategory));
//    var listData = jsonDecode(response.body);
//    print(urlGetCategory);
//    setState((){
//      _dataCategory = listData;
//    });
//    print("Data Category : $listData");
//  }
//}