import 'dart:convert';

import '/config/app_config.dart';
import '/util/exception.dart';
import '../models/authenticated_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticatedRemoteDataSource {
  Future<AuthenticatedModel> getAuthenticated(String email, String password);
}

class AuthenticatedRemoteDataSourceImpl
    implements AuthenticatedRemoteDataSource {
  AuthenticatedRemoteDataSourceImpl();

  @override
  Future<AuthenticatedModel> getAuthenticated(
      String email, String password) async {
    String? passwordVerify;
    int amountVerify = 0;
    if (email == 'alice@test.com') {
      passwordVerify = 'alice123';
      amountVerify = 800;
    }
    if (email == 'bob@test.com') {
      passwordVerify = 'bob123';
      amountVerify = 1000;
    }

    if (password == passwordVerify) {
      return AuthenticatedModel.fromJson({
        'authenticated': {
          'is_authenticated': true,
          'name': email,
          'amount': amountVerify,
        }
      });
    } else {
      throw FetchDataException();
    }
  }
}
