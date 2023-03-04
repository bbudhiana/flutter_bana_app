import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../util/datasource/db_helper.dart';
import '../../../../util/datasource/db_shared_preferences.dart';
import '../../../../util/exception.dart';
import '../../../user/data/models/user_model.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> get status;
  Future<UserModel> getLogin(String name, String password);
  void getLogout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();
  DbHelper helper = DbHelper();
  DbSharedPreferences helperSharePreferences = DbSharedPreferences();

  @override
  Future<AuthModel> get status async {
    await Future<void>.delayed(const Duration(seconds: 1));

    //String name = "alice";
    //String password = "alice123";

    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final String name = prefs.getString('name') ?? "";
    final String password = prefs.getString('password') ?? "";

    /* var name = helperSharePreferences.getDataString('name') ?? "uhuy";
    var password = helperSharePreferences.getDataString('password') ?? 'uhuy'; */

    final responsedata = await helper.getAuthStatus(name, password);
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

  /* @override
  Future<AuthModel> getLogin(String name, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    String name = "alice";
    String password = "alice123";
    final responsedata = await helper.getAuthStatus(name, password);

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
  } */

  @override
  Future<UserModel> getLogin(String name, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final responsedata =
        await helper.getDataUserByNameAndPassword(name, password);

    if (responsedata.isNotEmpty) {
      //input data user di sharedpreferences
      /* helperSharePreferences.inputDataString('name', name);
      helperSharePreferences.inputDataString('password', password); */
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('name', name);
      prefs.setString('password', password);
      return UserModel.fromJson(responsedata);
    } else {
      throw FetchDataException();
    }
  }

  @override
  Future<void> getLogout() async {
    //hapus data di sharedpreferences
    /* helperSharePreferences.deleteDataString('name');
    helperSharePreferences.deleteDataString('password'); */
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('password');
  }
}
