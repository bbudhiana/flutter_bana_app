import 'package:formz/formz.dart';

enum FirstnameValidationError { empty }

class FirstName extends FormzInput<String, FirstnameValidationError> {
  const FirstName.pure() : super.pure('');
  const FirstName.dirty([super.value = '']) : super.dirty();

  @override
  FirstnameValidationError? validator(String? value) {
    return value!.isEmpty == true ? FirstnameValidationError.empty : null;
  }
}
