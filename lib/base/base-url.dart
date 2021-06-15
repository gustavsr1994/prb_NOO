import 'dart:convert';
import 'package:http/http.dart';

class BaseUrl {
  static String domain = "http://119.18.157.236:8893/";

  static String baseUrl = domain + "api/";

  //login
  static String urlLogin = baseUrl + "Login?username={username}&password={password}";

  //file
  static String urlFile = baseUrl + "Files/GetFiles?fileName=";

  basicAuth() async{
    String usernameAuth = 'test';
    String passwordAuth = 'test456';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    print(basicAuth);
    Response r = await get(baseUrl + urlFile,headers: <String, String>{'authorization': basicAuth});
    print(r.statusCode);
    print(r.body);

    return urlFile;
  }
}