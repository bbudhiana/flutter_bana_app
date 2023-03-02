import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String password;
  final int amount;

  const UserModel({
    required this.id,
    required this.name,
    required this.password,
    required this.amount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        password: json['password'],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'password': password, 'amount': amount};

  User toEntity() {
    return User(
      id: id,
      name: name,
      password: password,
      amount: amount,
    );
  }

  @override
  List<Object?> get props => [id, name, password, amount];
}
