import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../presentation/models/models.dart';
import '../../../../authentication/domain/usecase/log_in.dart';
import '../../../../user/domain/entities/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /* LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository, */
  LoginBloc(LogIn logIn)
      : _logIn = logIn,
        super(const LoginState(visibility: false)) {
    on<LoginNameChanged>(_onNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<VisibilityPasswordChanged>(_onVisibility);
  }

  //final AuthRepository _authRepository;
  final LogIn _logIn;

  void _onVisibility(VisibilityPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(visibility: event.visibility));
  }

  void _onNameChanged(
    LoginNameChanged event,
    Emitter<LoginState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      name: name,
      isValid: Formz.validate([state.password, name]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.name]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      /* final res = await _getAuthentication.execute(
          state.name.value, state.password.value);
      */
      //final res = await _authRepository.logIn(state.name.value, state.password.value);
      final res = await _logIn.execute(state.name.value, state.password.value);

      res.fold(
        (failure) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            responseMessage: failure.message,
          ));
        },
        (data) {
          emit(state.copyWith(status: FormzSubmissionStatus.success, user: data, responseMessage: "success login"));
        },
      );
    }
  }
}
