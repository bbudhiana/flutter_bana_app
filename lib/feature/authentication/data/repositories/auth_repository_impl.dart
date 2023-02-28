import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../util/exception.dart';
import '../../../../util/failure.dart';
import '../../../user/domain/entities/user.dart';
import '../../domain/entities/auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  final _controller = StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get status async* {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      final result = await authRemoteDataSource.status;

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
  Future<Either<Failure, User>> logIn(String name, String password) async {
    try {
      final result = await authRemoteDataSource.getLogin(name, password);
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(AuthenticationStatus.authenticated),
      );

      //return berupa Weather Data Model maka harus konversi ke Weather Entity Model
      return Right(result.toEntity());
    } on FetchDataException {
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(AuthenticationStatus.unauthenticated),
      );
      return const Left(ServerFailure('Server error, please wait for a while'));
    } on SocketException {
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(AuthenticationStatus.unknown),
      );
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  void logOut() {
    //misal proses hapus token di sharepreferences agar tidak login lagi
    //dan masukkan dalam stream authenticationstatus dengan state unauthenticated
    authRemoteDataSource.getLogout();
    return _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  void dispose() => _controller.close();
}
