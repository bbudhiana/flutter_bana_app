import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String token;

  const LoginModel({
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(token: json['data']['token']);

  Map<String, dynamic> toJson() => {"token": token};

  @override
  List<Object?> get props => [token];
}
