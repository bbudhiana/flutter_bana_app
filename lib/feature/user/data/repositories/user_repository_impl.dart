import 'dart:io';

import 'package:dartz/dartz.dart';

import '/util/exception.dart';
import '/util/failure.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/remote_data_source.dart';

//WeatherRepositoryImpl terima eksekusi dari Usecase
//Di sinilah terjadi proses dari Domain ke Data
//Juga terjadi proses dari Data ke Domain (result.toEntity)
//Output Berhasil dalam bentuk Object Entity, jika gagal maka return object Failure
class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);

      //return berupa Weather Data Model maka harus konversi ke Weather Entity Model
      return Right(result.toEntity());
    } on FetchDataException {
      return const Left(ServerFailure('Server error, please wait for a while'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
