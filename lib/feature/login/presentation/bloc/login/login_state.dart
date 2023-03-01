part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Name name;
  final Password password;
  final bool visibility;
  final String responseMessage;
  final bool loginSuccess;

  const LoginState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.password = const Password.pure(),
    required this.visibility,
    this.responseMessage = '',
    this.loginSuccess = false,
  });

  LoginState copyWith(
      {FormzStatus? status,
      Name? name,
      Password? password,
      bool? visibility,
      String? responseMessage,
      bool? loginSuccess}) {
    return LoginState(
        status: status ?? this.status,
        name: name ?? this.name,
        password: password ?? this.password,
        visibility: visibility ?? this.visibility,
        responseMessage: responseMessage ?? this.responseMessage,
        loginSuccess: loginSuccess ?? this.loginSuccess);
  }

  @override
  List<Object> get props =>
      [status, name, password, visibility, responseMessage, loginSuccess];
}
