import 'package:dartz/dartz.dart';
import 'package:flutter_bana_app/feature/user/domain/entities/user.dart';

import '../../../../util/failure.dart';
import '../repositories/auth_repository.dart';

class LogOut {
  final AuthRepository repository;

  LogOut(this.repository);

  void execute() {
    repository.logOut();
  }
}
