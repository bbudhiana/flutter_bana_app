part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginNameChanged extends LoginEvent {
  const LoginNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
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
