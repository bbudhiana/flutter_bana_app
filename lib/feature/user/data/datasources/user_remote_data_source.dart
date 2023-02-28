import 'dart:convert';

import '../../../../util/datasource/db_helper.dart';
import '/util/exception.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserByNameAndPassword(String name, String password);
  Future<UserModel> getCurrentUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  DbHelper helper = DbHelper();
  UserRemoteDataSourceImpl();

  @override
  Future<UserModel> getUserByNameAndPassword(
      String name, String password) async {
    final response = await helper.getDataUserByNameAndPassword2(name, password);

    if (response.isNotEmpty) {
      return UserModel.fromJson(json.decode(response.toString()));
    } else {
      throw FetchDataException();
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    String name = "alice";
    final response = await helper.getCurrentUser(name);

    if (response.isNotEmpty) {
      return UserModel.fromJson(json.decode(response.toString()));
    } else {
      throw FetchDataException();
    }
  }
}
