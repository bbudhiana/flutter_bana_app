import 'package:dartz/dartz.dart';

import '../../../../utils/failure.dart';
import '../../domain/entities/weather.dart';

//Repo fungsi dari Object Entity Weather
abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
