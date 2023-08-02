part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final Name name;
  final Password password;
  final bool visibility;
  final String responseMessage;
  final User user;
  final bool isValid;

  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.name = const Name.pure(),
    this.password = const Password.pure(),
    this.responseMessage = '',
    required this.visibility,
    this.user = User.empty,
    this.isValid = false,
  });

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Name? name,
    Password? password,
    String? responseMessage,
    bool? visibility,
    User? user,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      name: name ?? this.name,
      password: password ?? this.password,
      responseMessage: responseMessage ?? this.responseMessage,
      visibility: visibility ?? this.visibility,
      user: user ?? this.user,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, name, password, visibility, responseMessage, user];
}
