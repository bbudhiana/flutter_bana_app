part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  //constructor kasih default status=unknown dan user=empty
  //definisinya dengan ._(nilai default)
  const AuthenticationState._(
      {this.status = AuthenticationStatus.unknown, this.user = User.empty});

  final AuthenticationStatus status;
  final User user;

  //state unknown adalah diisi dengan nilai default pertama kali AuthenticationState dibuat
  //':' artinya diisi dengan ... (baca Named Constructor)
  const AuthenticationState.unknown() : this._();

  //state authenticated adalah kelas ini diisi dengan status=authenticated dan user=user
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  //statue unauthenticated adalah kelas ini dengan diisi status=unauthenticated
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}

//class AuthenticationInitial extends AuthenticationState {}
