import '../repositories/auth_repository.dart';

class LogOut {
  final AuthRepository repository;

  LogOut(this.repository);

  void execute() {
    repository.logOut();
  }
}
