import 'package:dartz/dartz.dart';
import '/feature/login/domain/entities/login.dart';
import '/feature/login/domain/repositories/login_repository.dart';
import '/util/failure.dart';

class GetAuthentication {
  final LoginRepository repository;

  GetAuthentication(this.repository);

  Future<Either<Failure, Login>> execute(String email, String password) {
    return repository.getAuthentication(email, password);
  }
}
