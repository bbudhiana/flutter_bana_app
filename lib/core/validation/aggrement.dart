import 'package:formz/formz.dart';

enum AggrementValidationError { empty }

class Aggrement extends FormzInput<bool, AggrementValidationError> {
  const Aggrement.pure() : super.pure(false);
  const Aggrement.dirty([super.value = false]) : super.dirty();

  @override
  AggrementValidationError? validator(bool? value) {
    return value == false ? AggrementValidationError.empty : null;
  }
}
