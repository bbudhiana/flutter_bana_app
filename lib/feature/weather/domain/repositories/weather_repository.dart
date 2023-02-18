import 'package:dartz/dartz.dart';

import '/util/failure.dart';
import '../../domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
