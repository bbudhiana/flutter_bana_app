part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

//Event ketika terjadi perubahan input city di widget, terima parameter cityName
class OnNameChanged extends UserEvent {
  final String name;

  const OnNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}
