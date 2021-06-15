// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'base-response.dart';
//
// enum RequestType { post, get }
//
// class BaseRepository{
//   final baseUrl = "http://119.18.157.236:8893/api";
//
//   fetch(String path, RequestType type,
//       {Map body,
//         Map<String, String> header,
//         String module = " "}) async {
//
//     var url = baseUrl + module + path;
//     print('url: $url');
//     print('body: $body');
//     HttpClient client = new HttpClient();
//     var req = type == RequestType.get
//         ? await client.getUrl(Uri.parse(url))
//         : await client.postUrl(Uri.parse(url));
//     req.headers.set('content-type', 'application/json');
//     req.add(utf8.encode(json.encode(body)));
//     HttpClientResponse response = await req.close();
//     String reply = await response.transform(utf8.decoder).join();
//     var responsez = json.decode(reply);
//     print('response: ${responsez.toString()}');
//     return responsez;
//
//
// //    return request.then((http.Response response) {
// //      final jsonBody = response.body;
// //      final statusCode = response.statusCode;
// //
// //      print(response.body);
// //      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
// //        throw new FetchDataException("Error $statusCode");
// //      }
// //
// //      final jsonMap = json.decode(jsonBody);
// //      final baseResponse = new BaseResponse<dynamic>.fromJson(jsonMap);
// //
// //      if (!baseResponse.success) {
// //        throw new FetchDataException(baseResponse.message);
// //      }
// //      return baseResponse.data;
// //    });
//   }
//
//   Future<dynamic> fetch2(String path, RequestType type,
//       {dynamic body,
//         Map<String, String> header,
//         String token,
//         String version = "",
//         String module = "/ems-api/"}) {
//     SharedPreferences.getInstance().then( (pref){
//
//     });
//     var url = baseUrl + version + module + path;
//     print(url);
//     print(body);
//     Map<String,String> headers = {'appsource':'EMS_MOBILE'};
//     headers.addAll({'content-type':"application/json"});
//     headers.addAll({'Authorization':'Bearer ${token!=null?token:"nothing"}'});
//     if(header!=null) headers.addAll(header);
//     var request = type == RequestType.get
//         ? http.get(url, headers: headers)
//         : http.post(url, headers: headers, body: (json.encode(body)));
//     return request.then((http.Response response) {
//       final jsonBody = response.body;
//       final statusCode = response.statusCode;
//       print('respBody: ${response.body}');
//       if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
//         throw new FetchDataException("$statusCode body: ${jsonBody!=null?jsonBody:"null"}");
//       }
//
//       final jsonMap = json.decode(jsonBody);
//       final baseResponse = new BaseResponse.fromJson(jsonMap);
//
//       if (!baseResponse.success) {
//         throw new FetchDataException(baseResponse.message);
//       }
//       return baseResponse.data;
//     });
//   }
// }
//
// class FetchDataException implements Exception {
//   String _message;
//
//   FetchDataException(this._message);
//
//   String toString() {
//     return "Error: $_message";
//   }
// }