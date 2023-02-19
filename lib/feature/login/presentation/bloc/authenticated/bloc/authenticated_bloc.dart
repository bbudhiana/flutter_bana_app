import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bana_app/feature/login/domain/usecases/get_authenticated.dart';

import '../../../../domain/entities/authenticated.dart';

part 'authenticated_event.dart';
part 'authenticated_state.dart';

class AuthenticatedBloc extends Bloc<AuthenticatedEvent, AuthenticatedState> {
  final GetAuthenticated _getAuthenticated;

  AuthenticatedBloc(this._getAuthenticated) : super(AuthenticatedLoading()) {
    on<AuthenticatedButtonPressedEvent>((event, emit) async {
      final email = event.email;
      final password = event.password;

      //beri state terlebih dahulu loading
      emit(AuthenticatedLoading());

      final result = await _getAuthenticated.execute(email, password);

      result.fold(
        (failure) {
          emit(AuthenticatedError(failure.message));
        },
        (data) {
          emit(AuthenticatedHasData(data));
        },
      );
    });
  }
}
