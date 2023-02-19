part of 'authenticated_bloc.dart';

abstract class AuthenticatedEvent extends Equatable {
  const AuthenticatedEvent();

  @override
  List<Object> get props => [];
}

class AuthenticatedButtonPressedEvent extends AuthenticatedEvent {
  const AuthenticatedButtonPressedEvent(
      {required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthenticatedEmailChangedEvent extends AuthenticatedEvent {
  const AuthenticatedEmailChangedEvent({required this.email});
  final String email;

  @override
  List<Object> get props => [email];
}

class AuthenticatedPasswordChangedEvent extends AuthenticatedEvent {
  const AuthenticatedPasswordChangedEvent({required this.password});
  final String password;

  @override
  List<Object> get props => [password];
}
