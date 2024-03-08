import 'dart:convert';


import '../../../../utils/datasource/db_helper.dart';
import '../../../../utils/datasource/prefs.dart';
import '../../../../utils/exception.dart';
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
    // Obtain shared preferences.
    /* final prefs = await SharedPreferences.getInstance();
    final String name = prefs.getString('name') ?? "";
    final String password = prefs.getString('password') ?? ""; */

    final String name = Prefs().getString('name') ?? "";
    final String password = Prefs().getString('password') ?? "";

    final response = await helper.getDataUserByNameAndPassword(name, password);
    if (response.isNotEmpty) {
      //return UserModel.fromJson(json.decode(response.toString()));
      return UserModel.fromJson(response);
    } else {
      throw FetchDataException();
    }
  }
}
