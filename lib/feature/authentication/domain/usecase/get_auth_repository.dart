import '../repositories/auth_repository.dart';

class GetAuthRepository {
  AuthRepository authRepository;

  GetAuthRepository(
    this.authRepository,
  );

  AuthRepository get authRepo {
    return authRepository;
  }
}
