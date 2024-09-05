import 'package:formz/formz.dart';

enum CountryValidationError { empty }

class Country extends FormzInput<String, CountryValidationError> {
  const Country.pure() : super.pure('');
  const Country.dirty([super.value = '']) : super.dirty();

  @override
  CountryValidationError? validator(String? value) {
    return value!.isEmpty == true ? CountryValidationError.empty : null;
  }
}
