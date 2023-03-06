import 'package:dartz/dartz.dart';
import '/features/user/domain/repositories/user_repository.dart';

import '../../../../utils/failure.dart';
import '../entities/user.dart';

class GetUserByNameAndPassword {
  final UserRepository repository;

  GetUserByNameAndPassword(this.repository);

  Future<Either<Failure, User>> execute(String name, String password) {
    return repository.getUserByNameAndPassword(name, password);
  }
}
