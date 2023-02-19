import 'package:equatable/equatable.dart';

import '../../domain/entities/authenticated.dart';

class AuthenticatedModel extends Equatable {
  final bool isAuthenticated;
  final String name;
  final int amount;

  const AuthenticatedModel({
    required this.isAuthenticated,
    required this.name,
    required this.amount,
  });

  factory AuthenticatedModel.fromJson(Map<String, dynamic> json) =>
      AuthenticatedModel(
        isAuthenticated: json['is_authenticated'],
        name: json['name'],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() => {
        'authenticated': [
          {
            'is_authenticated': isAuthenticated,
            'name': name,
            'amount': amount,
          },
        ]
      };

  Authenticated toEntity() => Authenticated(
        isAuthenticated: isAuthenticated,
        name: name,
        amount: amount,
      );

  @override
  List<Object?> get props => [
        isAuthenticated,
        name,
        amount,
      ];
}
