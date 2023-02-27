import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_current_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUser _getCurrentUser;

  //Bloc WeatherBloc terima USECASE get_current_weather utuk akses data
  UserBloc(this._getCurrentUser) : super(UserEmpty()) {
    on<OnNameChanged>(
      (event, emit) async {
        //final name = event.name;

        emit(UserLoading());

        final result = await _getCurrentUser.execute();
        result.fold(
          (failure) {
            emit(UserError(failure.message));
          },
          (data) {
            emit(UserHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 1500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
