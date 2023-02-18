import 'package:formz/formz.dart';

enum AggrementValidationError { empty }

class Aggrement extends FormzInput<bool, AggrementValidationError> {
  const Aggrement.pure() : super.pure(false);
  const Aggrement.dirty([bool value = false]) : super.dirty(value);

  @override
  AggrementValidationError? validator(bool? value) {
    return value == false ? AggrementValidationError.empty : null;
  }
}
