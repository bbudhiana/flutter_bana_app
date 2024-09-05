import 'package:formz/formz.dart';

enum LastnameValidationError { empty, invalid }

class LastName extends FormzInput<String, LastnameValidationError> {
  const LastName.pure() : super.pure('');
  const LastName.dirty([super.value = '']) : super.dirty();

  @override
  LastnameValidationError? validator(String? value) {
    return value!.isEmpty == true ? LastnameValidationError.empty : null;
  }
}
