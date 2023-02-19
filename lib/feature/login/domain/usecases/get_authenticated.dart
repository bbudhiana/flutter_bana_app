import 'package:dartz/dartz.dart';
import '../entities/authenticated.dart';

import '../../../../util/failure.dart';
import '../repositories/authenticated_repository.dart';

class GetAuthenticated {
  final AuthenticatedRepository repository;

  GetAuthenticated(this.repository);
  Future<Either<Failure, Authenticated>> execute(
      String email, String password) {
    return repository.getAuthenticated(email, password);
  }
}
