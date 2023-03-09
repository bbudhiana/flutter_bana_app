import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../user/domain/entities/user.dart';
import '../../../user/domain/usecases/get_current_user.dart';
import '../../domain/entities/auth.dart';
import '../../domain/usecase/get_status.dart';
import '../../domain/usecase/log_out.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    GetStatus getStatus,
    GetCurrentUser getCurrentUser,
    LogOut logOut,
  )   : _getStatus = getStatus,
        _getCurrentUser = getCurrentUser,
        _logOut = logOut,
        super(const AuthState.unknown()) {
    _authenticationStatusSubscription =
        _getStatus.execute().listen((status) => _authStatusChanged(status));
  }

  Future<void> _authStatusChanged(AuthenticationStatus status) async {
    switch (status) {
      case AuthenticationStatus.unauthenticated:
        emit(const AuthState.unauthenticated());
        break;
      case AuthenticationStatus.authenticated:
        final user = await _getCurrentUser.execute();
        user.fold((failure) {
          emit(const AuthState.unauthenticated());
        }, (data) {
          emit(AuthState.authenticated(data));
        });
        break;
      case AuthenticationStatus.unknown:
        emit(const AuthState.unknown());
        break;
    }
  }

  void logOutRequest() {
    _logOut.execute();
  }

  final GetStatus _getStatus;
  final GetCurrentUser _getCurrentUser;
  final LogOut _logOut;

  //dibuat late karena baru bisa diinisiasi setelah dapat status nya di _authenticationRepository.status
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

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
