import 'package:formz/formz.dart';

enum CityValidationError { empty }

class City extends FormzInput<String, CityValidationError> {
  const City.pure() : super.pure('');
  const City.dirty([String value = '']) : super.dirty(value);

  @override
  CityValidationError? validator(String? value) {
    return value!.isEmpty == true ? CityValidationError.empty : null;
  }
}
