import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_bana_app/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../user/domain/entities/user.dart';
import '/feature/login/presentation/models/models.dart';
import '../../../../authentication/domain/usecase/log_in.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        /* LoginBloc(LogIn logIn)
      : _logIn = logIn, */
        super(const LoginState(visibility: false)) {
    on<LoginNameChanged>(_onNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<VisibilityPasswordChanged>(_onVisibility);
  }

  final AuthRepository _authRepository;
  //final LogIn _logIn;

  void _onVisibility(
      VisibilityPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(visibility: event.visibility));
  }

  void _onNameChanged(
    LoginNameChanged event,
    Emitter<LoginState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([state.password, name]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.name]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      /* final res = await _getAuthentication.execute(
          state.name.value, state.password.value);
      */
      final res =
          await _authRepository.logIn(state.name.value, state.password.value);
      //final res = await _logIn.execute(state.name.value, state.password.value);

      res.fold(
        (failure) {
          emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            responseMessage: failure.message,
          ));
        },
        (data) {
          emit(state.copyWith(
              status: FormzStatus.submissionSuccess,
              user: data,
              responseMessage: "success login"));
        },
      );
    }
  }
}
