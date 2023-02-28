import 'package:dartz/dartz.dart';

import '../../../../util/failure.dart';
import '../../../user/domain/entities/user.dart';
import '../entities/auth.dart';

abstract class AuthRepository {
  Stream<AuthenticationStatus> get status;
  Future<Either<Failure, User>> logIn(String name, String password);
  void logOut();
}
