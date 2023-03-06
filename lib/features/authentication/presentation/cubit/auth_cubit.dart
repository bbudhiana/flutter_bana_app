import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../user/domain/entities/user.dart';
import '../../../user/domain/repositories/user_repository.dart';
import '../../domain/entities/auth.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status
        .listen((status) => _authStatusChanged(status));
  }

  Future<void> _authStatusChanged(AuthenticationStatus status) async {
    switch (status) {
      case AuthenticationStatus.unauthenticated:
        emit(const AuthState.unauthenticated());
        break;
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        emit(user != null
            ? AuthState.authenticated(user)
            : const AuthState.unauthenticated());
        break;
      case AuthenticationStatus.unknown:
        emit(const AuthState.unknown());
        break;
    }
  }

  void logOutRequest() {
    _authenticationRepository.logOut();
  }

  final AuthRepository _authenticationRepository;
  final UserRepository _userRepository;

  //dibuat late karena baru bisa diinisiasi setelah dapat status nya di _authenticationRepository.status
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  Future<User?> _tryGetUser() async {
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
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(change);
  }
}
