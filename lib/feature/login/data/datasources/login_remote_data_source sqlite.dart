import '../../../../util/datasource/db_helper.dart';
import '/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../../../core/datasources/base_response.dart';

abstract class LoginRemoteDataSourceSqlite {
  Future<BaseResponse> getAuthentication(String email, String password);
}

class LoginRemoteDataSourceSqliteImpl implements LoginRemoteDataSourceSqlite {
  DbHelper helper = DbHelper();
  LoginRemoteDataSourceSqliteImpl();

  @override
  Future<BaseResponse> getAuthentication(String email, String password) async {
    try {
      final responsedata =
          await helper.getDataUserByNameAndPassword(email, password);
      if (responsedata.isEmpty) {
        Map<String, dynamic> responseContent = {
          "code": 401,
          "status": "Error",
          "data": null,
        };
        return BaseResponse.fromJson(responseContent);
      }
      Map<String, dynamic> responseContent = {
        "code": 200,
        "status": "Ok",
        "message": "",
        "data": responsedata,
        "error": ""
      };

      return BaseResponse.fromJson(responseContent);
    } on DioError catch (e) {
      return BaseResponse(
          code: e.response?.data['code'],
          status: e.response?.data['status'],
          message: e.response?.data['message'],
          data: null,
          error: e.response?.data['error']);
    }
  }
}
