abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);
}

class ServerException extends AppException {
  const ServerException(super.message, [super.stackTrace]);
}

class CacheException extends AppException {
  const CacheException([super.message = 'Cache error', super.stackTrace]);
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection', super.stackTrace]);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Unauthorized', super.stackTrace]);
}

class ValidationException extends AppException {
  final Map<String, List<String>> errors;

  const ValidationException(this.errors, [String message = 'Validation failed'])
      : super(message);

  @override
  String toString() => 'ValidationException: $message\nErrors: $errors';
}
