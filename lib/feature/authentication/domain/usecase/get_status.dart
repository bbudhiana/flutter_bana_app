import '../entities/auth.dart';
import '../repositories/auth_repository.dart';

class GetStatus {
  final AuthRepository authRepository;

  GetStatus(this.authRepository);

  Stream<AuthenticationStatus> execute() {
    return authRepository.status;
  }
}
