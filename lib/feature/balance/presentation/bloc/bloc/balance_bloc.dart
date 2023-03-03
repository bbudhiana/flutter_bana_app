import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bana_app/feature/authentication/domain/repositories/auth_repository.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(BalanceInitial()) {
    on<BalanceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final AuthRepository _authRepository;
}
