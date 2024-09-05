import 'package:formz/formz.dart';

enum PhoneValidationError { empty }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');
  const Phone.dirty([super.value = '']) : super.dirty();

  @override
  PhoneValidationError? validator(String? value) {
    return value!.isEmpty == true ? PhoneValidationError.empty : null;
  }
}
