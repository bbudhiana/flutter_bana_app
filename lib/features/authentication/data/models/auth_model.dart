import 'package:equatable/equatable.dart';

import '../../domain/entities/auth.dart';

class AuthModel extends Equatable {
  final AuthenticationStatus status;
  const AuthModel({
    required this.status,
  });

  @override
  List<Object> get props => [status];

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    switch (json['status']) {
      case 'authenticated':
        return const AuthModel(status: AuthenticationStatus.authenticated);
      case 'unauthenticated':
        return const AuthModel(status: AuthenticationStatus.unauthenticated);
      default:
        return const AuthModel(status: AuthenticationStatus.unknown);
    }
  }

  Map<String, dynamic> toJson() {
    switch (status) {
      case AuthenticationStatus.authenticated:
        return {'status': 'authenticated'};
      case AuthenticationStatus.unauthenticated:
        return {'status': 'unauthenticated'};
      default:
        return {'status': 'unknown'};
    }
  }

  //Fungsi ini penting untuk konversi mapping object Data Model kembali ke Object Entity
  Auth toEntity() => Auth(status: status);
}
