import 'package:dartz/dartz.dart';
import '/util/failure.dart';
import '../../domain/entities/user.dart';
import '../repositories/user_repository.dart';

class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Failure, User>> execute() {
    return repository.getCurrentUser();
  }
}
