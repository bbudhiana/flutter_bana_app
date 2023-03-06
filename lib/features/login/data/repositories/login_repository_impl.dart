import 'dart:io';

import '/features/login/data/datasources/login_remote_data_source%20sqlite.dart';

import '/features/login/data/models/login_model.dart';
import 'package:dartz/dartz.dart';
import '/features/login/data/datasources/login_remote_data_source.dart';
import '/features/login/domain/entities/login.dart';
import '/features/login/domain/repositories/login_repository.dart';
import '../../../../utils/exception.dart';
import '../../../../utils/failure.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSourceSqlite remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Login>> getAuthentication(
      String email, String password) async {
    dynamic result;

    try {
      result = await remoteDataSource.getAuthentication(email, password);
      if (result.loginEntity().data == null) {
        return const Left(DataFailure("Login Failed"));
      }
      return Right(result.loginEntity());
    } on FetchDataException {
      return Left(ServerFailure(result.message.toString()));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }
}
