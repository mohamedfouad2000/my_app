import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/errors/failures.dart';
import 'package:my_app/core/network/network_info.dart';
import 'package:my_app/core/utils/hanlders/api_error_factory.dart';
import 'package:my_app/core/utils/hanlders/api_error_model.dart';
import 'package:my_app/core/utils/hanlders/local_status_codes.dart';

class RepoImplCallHandler<T> {
  final NetworkInfo networkInfo;
  RepoImplCallHandler(this.networkInfo);

  Future<Either<Failure, T>> call(Future<T> Function() datasourceCall) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await datasourceCall());
      } on DataParsingException catch (e) {
        return Left(
          DataParsingFailure(
            ApiErrorModel(
              message: e.cause,
              icon: Icons.data_array,
              statusCode: LocalStatusCodes.badResponse,
            ),
          ),
        );
      } on FetchDataException catch (e) {
        return Left(
          ConnectionFailure(
            ApiErrorModel(
              message: e.message,
              icon: Icons.wifi_off,
              statusCode: LocalStatusCodes.connectionError,
            ),
          ),
        );
      } on ServerException catch (e) {
        return Left(ServerFailure(ApiErrorFactory.defaultError()));
      } on AuthException catch (e) {
        return Left(
          AuthFailure(
            ApiErrorModel(
              message: e.cause,
              icon: Icons.lock,
              statusCode: 401,
            ),
          ),
        );
      } on DioException catch (e) {
        final errorModel = _mapDioErrorToApiError(e);
        return Left(ServerFailure(errorModel));
      } catch (e) {
        return Left(
            AmbiguousFailure(ApiErrorFactory.defaultError(e.toString())));
      }
    } else {
      return Left(ConnectionFailure(ApiErrorFactory.noInternet()));
    }
  }

  ApiErrorModel _mapDioErrorToApiError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ApiErrorModel(
          message: 'Connection timed out',
          icon: Icons.timer_off,
          statusCode: LocalStatusCodes.connectionTimeout,
        );
      case DioExceptionType.sendTimeout:
        return ApiErrorModel(
          message: 'Send timeout',
          icon: Icons.send_time_extension,
          statusCode: LocalStatusCodes.sendTimeout,
        );
      case DioExceptionType.receiveTimeout:
        return ApiErrorModel(
          message: 'Receive timeout',
          icon: Icons.schedule,
          statusCode: LocalStatusCodes.receiveTimeout,
        );
      case DioExceptionType.badCertificate:
        return ApiErrorModel(
          message: 'Bad certificate',
          icon: Icons.security,
          statusCode: LocalStatusCodes.badCertificate,
        );
      case DioExceptionType.badResponse:
        return ApiErrorModel(
          message: e.response?.data['meta']?['message'] ??
              'Bad response from server',
          icon: Icons.http,
          statusCode: LocalStatusCodes.badResponse,
        );
      case DioExceptionType.cancel:
        return ApiErrorModel(
          message: 'Request cancelled',
          icon: Icons.cancel,
          statusCode: LocalStatusCodes.cancel,
        );
      case DioExceptionType.unknown:
      default:
        return ApiErrorFactory.defaultError();
    }
  }
}
