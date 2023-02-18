import 'package:dartz/dartz.dart';
import '../../../../feature/login/domain/entities/login.dart';
import '../../../../util/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> getAuthentication(
      String email, String password);
}
