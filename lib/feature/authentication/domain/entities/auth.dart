import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final AuthenticationStatus status;

  const Auth({required this.status});

  @override
  List<Object?> get props => [status];
}
