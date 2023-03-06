import 'package:dartz/dartz.dart';

import '../../../../utils/failure.dart';
import '../../domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> getUserByNameAndPassword(
      String name, String password);
}
