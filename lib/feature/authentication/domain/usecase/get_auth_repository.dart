import '../repositories/auth_repository.dart';

class GetAuthRepository {
  final AuthRepository authRepository;

  GetAuthRepository(this.authRepository);

  AuthRepository execute() {
    return authRepository;
  }
}
