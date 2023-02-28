import 'package:flutter_bana_app/feature/user/domain/repositories/user_repository.dart';

import '../repositories/auth_repository.dart';

class GetAuthRepository {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  GetAuthRepository(this.authRepository, this.userRepository);

  AuthRepository executeAuthRepo() {
    return authRepository;
  }

  UserRepository executeUserRepo() {
    return userRepository;
  }
}
