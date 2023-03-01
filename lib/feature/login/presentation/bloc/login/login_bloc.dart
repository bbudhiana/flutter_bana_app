import 'dart:core';
import '../../models/name.dart';
import '/di/injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '/feature/login/domain/usecases/get_authentication.dart';
import '/feature/login/presentation/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetAuthentication _getAuthentication;

  LoginBloc(this._getAuthentication)
      : super(const LoginState(visibility: false)) {
    on<LoginNameChanged>(_onNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<VisibilityPasswordChanged>(_onVisibility);
  }

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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final res = await _getAuthentication.execute(
          state.name.value, state.password.value);

      res.fold(
        (failure) {
          emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              responseMessage: failure.message,
              loginSuccess: false));
        },
        (data) {
          sharedPreferences.setString("name", state.name.value);
          sharedPreferences.setBool("islogin", data.code != 200 ? false : true);
          emit(state.copyWith(
              status: FormzStatus.submissionSuccess,
              //responseMessage: data.message,
              responseMessage: 'Login Success',
              loginSuccess: data.code != 200 ? false : true));
        },
      );
    }
  }
}
