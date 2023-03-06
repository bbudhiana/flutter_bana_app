import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final int? code;
  final Map? data;
  final String? message;

  const Login({this.code, this.data, this.message});

  @override
  List<Object?> get props => [code, data, message];
}
