import 'package:equatable/equatable.dart';

class Authenticated extends Equatable {
  final bool isAuthenticated;
  final String name;
  final int amount;

  const Authenticated({
    required this.isAuthenticated,
    required this.name,
    required this.amount,
  });

  @override
  List<Object?> get props => [isAuthenticated, name, amount];
}
