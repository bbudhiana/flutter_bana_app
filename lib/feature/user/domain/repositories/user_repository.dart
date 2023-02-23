import 'package:dartz/dartz.dart';

import '/util/failure.dart';
import '../../domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser(String name);
  Future<Either<Failure, User>> getUserByNameAndPassword(
      String name, String password);
}
