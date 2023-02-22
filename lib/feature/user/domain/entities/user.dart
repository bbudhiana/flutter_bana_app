import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String password;
  final int amount;

  const User({
    required this.id,
    required this.name,
    required this.password,
    required this.amount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        password,
        amount,
      ];
}
