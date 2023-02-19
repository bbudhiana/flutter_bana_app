import 'dart:io';

import 'package:flutter_bana_app/util/failure.dart';

import 'package:flutter_bana_app/feature/login/domain/entities/authenticated.dart';

import 'package:dartz/dartz.dart';

import '../../../../util/exception.dart';
import '../../domain/repositories/authenticated_repository.dart';
import '../datasources/authenticated_remote_data_source.dart';

class AuthenticatedRepositoryImpl implements AuthenticatedRepository {
  final AuthenticatedRemoteDataSource remoteDataSource;

  AuthenticatedRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, Authenticated>> getAuthenticated(
      String email, String password) async {
    try {
      final result = await remoteDataSource.getAuthenticated(email, password);
      return Right(result.toEntity());
    } on FetchDataException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
