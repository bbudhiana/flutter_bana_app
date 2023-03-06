part of 'auth_cubit.dart';

class AuthState extends Equatable {
  //constructor kasih default status=unknown dan user=empty
  //definisinya dengan ._(nilai default)
  const AuthState._(
      {this.status = AuthenticationStatus.unknown, this.user = User.empty});

  final AuthenticationStatus status;
  final User user;

  //state unknown adalah diisi dengan nilai default pertama kali AuthenticationState dibuat
  //':' artinya diisi dengan ... (baca Named Constructor)
  const AuthState.unknown() : this._();

  //state authenticated adalah kelas ini diisi dengan status=authenticated dan user=user
  const AuthState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  //statue unauthenticated adalah kelas ini dengan diisi status=unauthenticated
  const AuthState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}

//class AuthInitial extends AuthState {}
