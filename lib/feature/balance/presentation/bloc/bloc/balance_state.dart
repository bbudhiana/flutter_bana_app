part of 'balance_bloc.dart';

abstract class BalanceState extends Equatable {
  const BalanceState();
  
  @override
  List<Object> get props => [];
}

class BalanceInitial extends BalanceState {}
