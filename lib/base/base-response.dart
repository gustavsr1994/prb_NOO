class BaseResponse {

  int status;
  String message;
  bool success;
  dynamic data;

  BaseResponse({this.status, this.message, this.data, this.success});

  BaseResponse.fromJson(dynamic item)
      : status = item['status'],
        message = item['message'],
        success = item['success'],
        data = item['data'];

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'success': success,
    'data': data,
  };
}