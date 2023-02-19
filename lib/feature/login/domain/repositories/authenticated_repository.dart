import 'package:dartz/dartz.dart';
import 'package:flutter_bana_app/feature/login/domain/entities/authenticated.dart';

import '../../../../util/failure.dart';

abstract class AuthenticatedRepository {
  Future<Either<Failure, Authenticated>> getAuthenticated(
      String email, String password);
}
