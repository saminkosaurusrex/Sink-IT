//Author: Samuel Kudnrat
//login: xkundrs00

class ApiException implements Exception {
  final String message;
  final String details;

  ApiException(this.message, this.details);

  @override
  String toString() => 'ApiException: $message\nDetails:$details';
}
