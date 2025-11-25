import 'package:flutter/material.dart';
import 'package:my_app/core/utils/hanlders/api_error_model.dart';
import 'package:my_app/core/utils/hanlders/local_status_codes.dart';

class ApiErrorFactory {
  static ApiErrorModel defaultError([String? message]) => ApiErrorModel(
        message: message ?? "Something went wrong",
        icon: Icons.error,
        statusCode: LocalStatusCodes.defaultError,
      );
  static ApiErrorModel noInternet() => ApiErrorModel(
        message: 'No internet connection',
        icon: Icons.wifi_off,
        statusCode: LocalStatusCodes.connectionError,
      );

  static ApiErrorModel dataParsing(String cause, [dynamic rawData]) =>
      ApiErrorModel(
        message: 'Data parsing error: $cause\nRaw Data: $rawData',
        icon: Icons.data_array,
        statusCode: LocalStatusCodes.badResponse,
      );
}
