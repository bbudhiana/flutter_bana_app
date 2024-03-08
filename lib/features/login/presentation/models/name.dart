import 'package:formz/formz.dart';

enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  //static final  _emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) return NameValidationError.empty;
    return null;
    //return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}
