import '../repositories/user_repository.dart';

class GetUserRepository {
  final UserRepository userRepository;

  GetUserRepository(this.userRepository);

  UserRepository execute() {
    return userRepository;
  }
}
