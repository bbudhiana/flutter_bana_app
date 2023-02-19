part of 'authenticated_bloc.dart';

abstract class AuthenticatedState extends Equatable {
  const AuthenticatedState();

  @override
  List<Object> get props => [];
}

class AuthenticatedLoading extends AuthenticatedState {}

class AuthenticatedError extends AuthenticatedState {
  final String message;

  const AuthenticatedError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthenticatedHasData extends AuthenticatedState {
  final Authenticated result;

  const AuthenticatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
