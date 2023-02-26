import 'dart:async';

import '../../../../util/datasource/db_helper.dart';
import '../../../../util/exception.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> get status;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();
  DbHelper helper = DbHelper();

  @override
  Future<AuthModel> get status async {
    await Future<void>.delayed(const Duration(seconds: 1));

    String email = "alice";
    String password = "alice123";
    final responsedata = await helper.getAuthStatus(email, password);

    if (responsedata.isNotEmpty) {
      return AuthModel.fromJson(responsedata);
    } else {
      throw FetchDataException();
    }
    /* if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw FetchDataException();
    } */
  }
}
