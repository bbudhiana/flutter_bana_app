import '../entities/auth.dart';

abstract class AuthRepository {
  Stream<AuthenticationStatus> get status;
  Future<void> logIn(String name, String password);
  void logOut();
}
