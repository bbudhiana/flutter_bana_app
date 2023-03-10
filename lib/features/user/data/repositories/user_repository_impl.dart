import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../../../utils/exception.dart';
import '../../../../utils/failure.dart';
import '../datasources/user_remote_data_source.dart';

//WeatherRepositoryImpl terima eksekusi dari Usecase
//Di sinilah terjadi proses dari Domain ke Data
//Juga terjadi proses dari Data ke Domain (result.toEntity)
//Output Berhasil dalam bentuk Object Entity, jika gagal maka return object Failure
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final result = await userRemoteDataSource.getCurrentUser();
      //return berupa Weather Data Model maka harus konversi ke Weather Entity Model
      return Right(result.toEntity());
    } on FetchDataException {
      return const Left(ServerFailure('Server error, please wait for a while'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, User>> getUserByNameAndPassword(
      String name, String password) async {
    try {
      final result =
          await userRemoteDataSource.getUserByNameAndPassword(name, password);

      //return berupa Weather Data Model maka harus konversi ke Weather Entity Model
      return Right(result.toEntity());
    } on FetchDataException {
      return const Left(ServerFailure('Server error, please wait for a while'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
