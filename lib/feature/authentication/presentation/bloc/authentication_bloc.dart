import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../user/domain/entities/user.dart';
import '../../../user/domain/repositories/user_repository.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../../domain/entities/auth.dart';
import '../../domain/repositories/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);

    //mendaftarkan event dari sebuah stream yang ada, kemudian 'dialirkan' ke state (AuthenticationStatusChanged)
    //default ketika pertama kali bloc digunakan, yaitu set stream status state
    _authenticationStatusSubscription = _authenticationRepository.status
        .listen((status) => add(_AuthenticationStatusChanged(status)));
  }

  final AuthRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  //method ini di override karena saat bloc tidak lagi digunakan akan ada proses
  //yaitu proses menutup seluruh subscription event dari authenticationstatus
  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    //pilihan state yang terjadi saat status authentication berubah
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        //cari dulu usernya, misal bisa diganti getUserByNameAndPassword
        final user = await _tryGetUser();
        return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated());
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  Future<User?> _tryGetUser() async {
    //misal ambil data dari sharedPreference yaitu name and password
    //kemudian ambil data dari user repository getUserByNameAndPassword
    try {
      final result = await _userRepository.getCurrentUser();
      result.fold(
        (failure) {
          return null;
        },
        (data) {
          return data;
        },
      );
    } catch (_) {
      return null;
    }

    /*  try {
      final user = await _userRepository.getCurrentUser();
      return Right(user);
    } catch (_) {
      return null;
    } */
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }
}
