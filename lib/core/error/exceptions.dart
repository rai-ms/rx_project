abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);
}

class ServerException extends AppException {
  const ServerException(String message, [StackTrace? stackTrace])
      : super(message, stackTrace);
}

class CacheException extends AppException {
  const CacheException([String message = 'Cache error', StackTrace? stackTrace])
      : super(message, stackTrace);
}

class NetworkException extends AppException {
  const NetworkException([String message = 'No internet connection', StackTrace? stackTrace])
      : super(message, stackTrace);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([String message = 'Unauthorized', StackTrace? stackTrace])
      : super(message, stackTrace);
}

class ValidationException extends AppException {
  final Map<String, List<String>> errors;

  const ValidationException(this.errors, [String message = 'Validation failed'])
      : super(message);

  @override
  String toString() => 'ValidationException: $message\nErrors: $errors';
}
