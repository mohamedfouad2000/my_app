import 'package:equatable/equatable.dart';
import 'package:my_app/core/utils/hanlders/api_error_model.dart';

abstract class Failure extends Equatable {
  final ApiErrorModel error;

  const Failure(this.error);

  @override
  List<Object?> get props => [error];
}

class ServerFailure extends Failure {
  const ServerFailure(super.error);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.error);
}

class CacheFailure extends Failure {
  const CacheFailure(super.error);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.error);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.error);
}

class AmbiguousFailure extends Failure {
  const AmbiguousFailure(super.error);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.error);
}

class DataParsingFailure extends Failure {
  const DataParsingFailure(super.error);
}

class AuthFailure extends Failure {
  const AuthFailure(super.error);
}
