part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

//State ketika object weather kosong
class UserEmpty extends UserState {}

//State ketika object weather sedang diload
class UserLoading extends UserState {}

//State ketika object User ouput nya error, tangkap error nya dalam message
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

//State ketika object User berhasil, outpunya adalah kelas User
class UserHasData extends UserState {
  final User result;

  const UserHasData(this.result);

  @override
  List<Object?> get props => [result];
}
