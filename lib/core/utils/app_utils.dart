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

String capitalizeWord(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
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

String formatEndDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  DateTime now = DateTime.now();

  final bool isPast = dateTime.isBefore(now);

  if (isPast) {
    return "Expired";
  }

  Duration difference = now.difference(dateTime).abs();

  int days = difference.inDays;
  int hours = difference.inHours.remainder(24);
  int minutes = difference.inMinutes.remainder(60);

  if (days > 0) {
    return '${days}d : ${hours}h : ${minutes}m left';
  }else if (days < 1) {
    return '${hours}h : ${minutes}m left';
  }else if (days < 1 && hours < 1) {
    return '${minutes}m left';
  }

  return '${days}d : ${hours}h : ${minutes}m left';
}

String extractUsernameFromTwitterUrl(String url) {
  Uri uri = Uri.parse(url);
  List<String> pathSegments = uri.pathSegments;
  if (pathSegments.isNotEmpty) {
    return pathSegments.last;
  } else {
    throw 'Invalid Twitter profile URL';
  }
}

String extractTweetIdFromTwitterUrl(String url) {
  final uri = Uri.parse(url);
  final segments = uri.pathSegments;
  return segments.last;
}





