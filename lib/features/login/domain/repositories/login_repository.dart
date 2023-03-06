import 'package:dartz/dartz.dart';
import '../../../../features/login/domain/entities/login.dart';
import '../../../../utils/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> getAuthentication(
      String email, String password);
}
