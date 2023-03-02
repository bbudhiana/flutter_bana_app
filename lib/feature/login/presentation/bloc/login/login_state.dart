part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Name name;
  final Password password;
  final bool visibility;
  final String responseMessage;
  final User user;

  const LoginState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.password = const Password.pure(),
    this.responseMessage = '',
    required this.visibility,
    this.user = User.empty,
  });

  LoginState copyWith({
    FormzStatus? status,
    Name? name,
    Password? password,
    String? responseMessage,
    bool? visibility,
    User? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      name: name ?? this.name,
      password: password ?? this.password,
      responseMessage: responseMessage ?? this.responseMessage,
      visibility: visibility ?? this.visibility,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props =>
      [status, name, password, visibility, responseMessage, user];
}
