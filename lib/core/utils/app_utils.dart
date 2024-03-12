import 'package:form_field_validator/form_field_validator.dart';

String shortenString(String input, int maxLength) {
  if (input.length <= maxLength) {
    return input;
  }
  return '${input.substring(0, maxLength)}...';
}

String shortenStringWithReadMore(String input, int maxLength) {
  if (input.length <= maxLength) {
    return input;
  }
  return '${input.substring(0, maxLength)}...Read more';
}

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Required*'),
  MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[0-9])', errorText: 'Password must contain at least one number'),
  PatternValidator(r'(?=.*?[A-Z])', errorText: 'Password must contain at least one uppercase letter'),
  PatternValidator(r'(?=.*?[a-z])', errorText: 'Password must contain at least one lowercase letter'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Passwords must have at least one special character')
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Required*'),
  EmailValidator(errorText: "Invalid email"),
]);

final requiredValidator = RequiredValidator(errorText: 'Required*');

String? matchPasswordValidator(String? password, String? confirmPassword) {
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}


