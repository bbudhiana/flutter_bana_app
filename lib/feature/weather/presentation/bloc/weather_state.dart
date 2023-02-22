import 'package:equatable/equatable.dart';
import '../../domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

//State ketika object weather kosong
class WeatherEmpty extends WeatherState {}

//State ketika object weather sedang diload
class WeatherLoading extends WeatherState {}

//State ketika object weather ouput nya error, tangkap error nya dalam message
class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}

//State ketika object weather berhasil, outpunya adalah kelas weather
class WeatherHasData extends WeatherState {
  final Weather result;

  const WeatherHasData(this.result);

  @override
  List<Object?> get props => [result];
}
