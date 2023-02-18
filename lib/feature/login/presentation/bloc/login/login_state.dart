part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Email email;
  final Password password;
  final bool visibility;
  final String responseMessage;
  final bool loginSuccess;

  const LoginState(
      {this.status = FormzStatus.pure,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      required this.visibility,
      this.responseMessage = '',
      this.loginSuccess = false});

  LoginState copyWith(
      {FormzStatus? status,
      Email? email,
      Password? password,
      bool? visibility,
      String? responseMessage,
      bool? loginSuccess}) {
    return LoginState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        visibility: visibility ?? this.visibility,
        responseMessage: responseMessage ?? this.responseMessage,
        loginSuccess: loginSuccess ?? this.loginSuccess);
  }

  @override
  List<Object> get props =>
      [status, email, password, visibility, responseMessage, loginSuccess];
}
