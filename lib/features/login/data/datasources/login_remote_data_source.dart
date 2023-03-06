import '/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../../../core/datasources/base_response.dart';

abstract class LoginRemoteDataSource {
  Future<BaseResponse> getAuthentication(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;
  late Dio _dio;
  LoginRemoteDataSourceImpl({required this.client}) {
    _dio = Dio();
  }

  @override
  Future<BaseResponse> getAuthentication(String email, String password) async {
    try {
      BaseOptions baseOptions = BaseOptions();

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'X-Authorization': ConfigEnvironment.apiKey
      };

      baseOptions.headers = headers;
      _dio.options = baseOptions;

      final res = await _dio.post(
        ConfigEnvironment.baseurl("/login"),
        data: {
          'username': email,
          'password': password,
        },
      );

      return BaseResponse.fromJson(res.data);
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
