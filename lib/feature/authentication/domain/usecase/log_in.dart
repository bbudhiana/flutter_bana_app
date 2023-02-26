import '../repositories/auth_repository.dart';

class LogIn {
  final AuthRepository repository;

  LogIn(this.repository);

  Future<void> execute(String name, String password) async {
    repository.logIn(name, password);
  }
}
