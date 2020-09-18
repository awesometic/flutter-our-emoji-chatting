import 'package:formz/formz.dart';

enum UserTextValidationError { invalid }

class UserText extends FormzInput<String, UserTextValidationError> {
  const UserText.pure() : super.pure('');
  const UserText.dirty([String value = '']) : super.dirty(value);

  @override
  UserTextValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : UserTextValidationError.invalid;
  }
}
