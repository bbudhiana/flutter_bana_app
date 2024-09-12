import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bana_app/features/authentication/domain/usecase/get_status.dart';
import 'package:flutter_bana_app/features/authentication/domain/usecase/log_out.dart';
import '/features/user/domain/usecases/get_current_user.dart';

import '../../../user/domain/entities/user.dart';
import '../../domain/entities/auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
    GetStatus getStatus,
    GetCurrentUser getCurrentUser,
    LogOut logOut,
  )   : _getStatus = getStatus,
        _getCurrentUser = getCurrentUser,
        _logOut = logOut,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);

    //mendaftarkan event dari sebuah stream yang ada, kemudian 'dialirkan' ke state (AuthenticationStatusChanged)
    //default ketika pertama kali bloc digunakan, yaitu set stream status state
    //AuthenticationStatusChanged hanya di trigger dari perubahan value _authenticationRepository.status
    //_authenticationStatusSubscription = _authenticationRepository.status.listen((status) => add(_AuthenticationStatusChanged(status)));
    _authenticationStatusSubscription = _getStatus.execute().listen((status) => add(_AuthenticationStatusChanged(status)));
  }
  final GetStatus _getStatus;
  final GetCurrentUser _getCurrentUser;
  final LogOut _logOut;
  /* final AuthRepository _authenticationRepository;
  final UserRepository _userRepository; */

  //dibuat late karena baru bisa diinisiasi setelah dapat status nya di _authenticationRepository.status
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

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
        print('ini ke triger bukan di awal, tapi by event misal  login');
        //cari dulu usernya, misal bisa diganti getUserByNameAndPassword
        //final user = await _tryGetUser();
        final user = await _getCurrentUser.execute();
        /* return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated()); */
        user.fold((failure) {
          return emit(const AuthenticationState.unauthenticated());
        }, (data) {
          return emit(AuthenticationState.authenticated(data));
        });
      //break;
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  /* Future<User?> _tryGetUser() async {
    //misal ambil data dari sharedPreference yaitu name and password
    //kemudian ambil data dari user repository getUserByNameAndPassword
    User? tampung;
    try {
      final result = await _userRepository.getCurrentUser();
      result.fold(
        (failure) {
          return null;
        },
        (data) {
          tampung = data;
          return data;
        },
      );
    } catch (_) {
      return null;
    }
    return tampung;
    /*  try {
      final user = await _userRepository.getCurrentUser();
      return Right(user);
    } catch (_) {
      return null;
    } */
  } */

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    //_authenticationRepository.logOut();
    _logOut.execute();
  }

  //Observasi setiap perubahan state bisa pake sistem observer ini
  @override
  void onChange(Change<AuthenticationState> change) {
    super.onChange(change);
    print(change);
  }
}
