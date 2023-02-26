import 'dart:async';
import 'dart:io';

import 'package:flutter_bana_app/util/failure.dart';

import 'package:flutter_bana_app/feature/authentication/domain/entities/auth.dart';

import 'package:dartz/dartz.dart';

import '../../../../util/exception.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  final _controller = StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get status async* {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      final result = await remoteDataSource.status;

      //return berupa Auth Data Model maka harus konversi ke Auth Entity Model
      yield result.toEntity().status;
    } on FetchDataException {
      yield AuthenticationStatus.unauthenticated;
    } on SocketException {
      yield AuthenticationStatus.unknown;
    }
    //apapun statusnya, harus di 'alirkan'
    yield* _controller.stream;
  }

  @override
  Future<void> logIn(String name, String password) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  void logOut() {
    // TODO: implement logOut
  }
}
