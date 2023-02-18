import '/core/entities/base_entity.dart';
/* import '../feature/login/domain/entities/login.dart';
import '../feature/register/domain/entities/register.dart'; */

class BaseResponse {
  int? code;
  String? status;
  String? message;
  dynamic data;
  String? error;

  BaseResponse(
      {required this.code,
      required this.status,
      required this.message,
      required this.data,
      required this.error});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: json["data"],
      error: json['error']);

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        'data': data,
        "message": message,
        "error": error
      };

  /* Register toEntity() => Register(
      code: code, status: status, message: message, data: data, error: error);
  Login loginEntity() => Login(code: code, message: message, data: data); */

  BaseEntity baseEntity() => BaseEntity(
      code: code, status: status, message: message, data: data, error: error);
}
