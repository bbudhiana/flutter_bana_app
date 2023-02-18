import 'dart:io';

import '/feature/login/data/models/login_model.dart';
import 'package:dartz/dartz.dart';
import '/feature/login/data/datasources/login_remote_data_source.dart';
import '/feature/login/domain/entities/login.dart';
import '/feature/login/domain/repositories/login_repository.dart';
import '/util/exception.dart';
import '/util/failure.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Login>> getAuthentication(
      String email, String password) async {
    dynamic result;
    try {
      result = await remoteDataSource.getAuthentication(email, password);
      return Right(result.loginEntity());
    } on FetchDataException {
      return Left(ServerFailure(result.message.toString()));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }
}
