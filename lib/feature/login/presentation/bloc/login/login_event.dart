part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class LoginGoogle extends LoginEvent {
  const LoginGoogle();
}

class ResponseMessage extends LoginEvent {
  const ResponseMessage(this.responseMessage);

  final String responseMessage;
}

class LoginSuccess extends LoginEvent {
  const LoginSuccess(this.loginSuccess);
  final bool loginSuccess;
}

class VisibilityPasswordChanged extends LoginEvent {
  const VisibilityPasswordChanged(this.visibility);

  final bool visibility;
}
