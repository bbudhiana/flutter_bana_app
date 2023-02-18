import 'package:equatable/equatable.dart';

class BaseEntity extends Equatable {
  final int? code;
  final String? status;
  final dynamic data;
  final String? message;
  final String? error;

  const BaseEntity(
      {this.code, this.status, this.data, this.message, this.error});

  @override
  List<Object?> get props => [code, status, data, message, error];
}
