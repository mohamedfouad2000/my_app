class AppException implements Exception {
  final String message;
  final String prefix;

  AppException(this.message, [this.prefix = 'Error']);

  @override
  String toString() => '$prefix: $message';
}

class DataParsingException implements Exception {
  final String cause; // الرسالة اللي توضح نوع الخطأ
  final dynamic rawData; // البيانات الخام اللي سببت المشكلة (اختياري)

  DataParsingException(this.cause, [this.rawData]);

  @override
  String toString() {
    if (rawData != null) {
      return 'DataParsingException: $cause\nRawData: $rawData';
    }
    return 'DataParsingException: $cause';
  }
}

class ErrorDataException implements Exception {
  String cause;
  ErrorDataException(this.cause);

  @override
  String toString() {
    return cause;
  }
}

class AuthException implements Exception {
  String cause;
  AuthException(
    this.cause,
  );

  @override
  String toString() {
    return cause;
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException(String message) : super(message, 'Invalid Request');
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message) : super(message, 'Unauthorized');
}

class NotFoundException extends AppException {
  NotFoundException(String message) : super(message, 'Not Found');
}

class InvalidInputException extends AppException {
  InvalidInputException(String message) : super(message, 'Invalid Input');
}

class ServerException extends AppException {
  ServerException(String message) : super(message, 'Internal Server Error');
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message, 'No Internet Connection');
}

class TimeoutException extends AppException {
  TimeoutException(String message) : super(message, 'Request Timeout');
}

class CacheException extends AppException {
  CacheException(String message) : super(message, 'Cache Error');
}
