import 'package:dartz/dartz.dart';

import '../../../../utils/failure.dart';
import '../../../user/domain/entities/user.dart';
import '../repositories/auth_repository.dart';

class LogIn {
  final AuthRepository repository;

  LogIn(this.repository);

  Future<Either<Failure, User>> execute(String name, String password) async {
    return repository.logIn(name, password);
  }
}
