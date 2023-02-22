import 'package:dartz/dartz.dart';
import '/util/failure.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';

//USE CASE ini jembatan antara Domain dengan Data source
//setiap usecase harus didaftarkan dalam injector agar bisa mengakses mengakses Data
//Dalam class ini :
//1. Input adalah GetCurrentWeather milik Domain
//2. Dalam injector, jika ada yg akses WeatherRepository maka akan di return implementasinya (WeatherRepositoryImpl)
//3. Dalam WeatherRepositoryImpl minta masukan remoteDataSource
//4. Dalam injector, jika ada yang akses remoteDataSource maka akan di return RemoteDataSourceImpl
class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
