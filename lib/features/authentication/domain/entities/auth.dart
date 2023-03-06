import 'package:equatable/equatable.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class Auth extends Equatable {
  final AuthenticationStatus status;

  const Auth({required this.status});

  @override
  List<Object?> get props => [status];
}
