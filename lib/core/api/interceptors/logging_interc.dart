import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor implements InterceptorsWrapper {
  const LoggingInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      log(
        '__________________________________________________________',
        name: 'Request',
      );
      log(
        options.path.toString(),
        name: 'Request Path',
      );
      log(
        options.headers.toString().replaceAll(',', ',\n'),
        name: 'Request Headers for ${options.path.toString()}',
      );
      log(
        options.queryParameters.toString().replaceAll(',', ',\n'),
        name: 'Request QueryParameters for ${options.path.toString()}',
      );
      log(options.data.toString().replaceAll(',', ',\n'),
          name: 'Request Data for ${options.path.toString()}');
    }

    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      log(
        '________________________________________________________',
        name: 'Response',
      );
      log(response.statusCode.toString(),
          name: 'Response Status Code for ${response.requestOptions.path}');
      log(
        response.data.toString(),
        name: 'Response Data for ${response.requestOptions.path}',
      );
    }

    return handler.next(response);
  }

  @override
  void onError(err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log(
        '___________________________________________________________',
        name: 'ERROR',
      );
      log(err.error.toString(), name: 'Error for ${err.requestOptions.path}');
      log(err.response.toString(),
          name: 'Error Response for ${err.requestOptions.path}');
      log(err.message.toString(),
          name: 'Error Message for ${err.requestOptions.path}');
    }

    return handler.next(err);
  }
}
