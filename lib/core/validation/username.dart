import 'package:formz/formz.dart';

enum UsernameValidationError { empty, invalid }

class UserName extends FormzInput<String, UsernameValidationError> {
  const UserName.pure() : super.pure('');
  const UserName.dirty([String value = '']) : super.dirty(value);
  static final containsUppercase = RegExp(r'[A-Z]');

  @override
  UsernameValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return UsernameValidationError.empty;
    }
    return containsUppercase.hasMatch(value)
        ? null
        : UsernameValidationError.invalid;
  }
}
