import 'package:dartz/dartz.dart';
import 'package:flutter_bana_app/feature/user/domain/repositories/user_repository.dart';

import '../../../../util/failure.dart';
import '../entities/user.dart';

class GetUserByNameAndPassword {
  final UserRepository repository;

  GetUserByNameAndPassword(this.repository);

  Future<Either<Failure, User>> execute(String name, String password) {
    return repository.getUserByNameAndPassword(name, password);
  }
}
