import 'package:formz/formz.dart';

enum PictureValidationError { empty }

class Picture extends FormzInput<String, PictureValidationError> {
  const Picture.pure() : super.pure('');
  const Picture.dirty([super.value = '']) : super.dirty();

  @override
  PictureValidationError? validator(String? value) {
    return value!.isEmpty == true ? PictureValidationError.empty : null;
  }
}
