import 'package:dartz/dartz.dart';
import '/features/login/domain/entities/login.dart';
import '/features/login/domain/repositories/login_repository.dart';
import '../../../../utils/failure.dart';

class GetAuthentication {
  final LoginRepository repository;

  GetAuthentication(this.repository);

  Future<Either<Failure, Login>> execute(String email, String password) {
    return repository.getAuthentication(email, password);
  }
}
