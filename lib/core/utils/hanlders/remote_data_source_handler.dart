import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/utils/hanlders/api_error_factory.dart';
import 'package:my_app/core/utils/hanlders/api_error_model.dart';
import 'package:my_app/core/utils/hanlders/local_status_codes.dart';
import 'package:my_app/core/utils/models/base_api_response_model.dart';

class RemoteDataSourceCallHandler {
  RemoteDataSourceCallHandler();

  Future<BaseApiResponseModel> call(Response res) async {
    try {
      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 204) {
        return BaseApiResponseModel.fromMap(res.data);
      }

      if (res.statusCode == 401) {
        throw ServerException(
          ApiErrorModel(
            message: 'Session expired, please login again',
            icon: Icons.lock,
            statusCode: 401,
          ).toString(),
        );
      } else {
        final message = BaseApiResponseModel.fromMap(res.data).meta?.message ??
            'Unknown error';
        throw ServerException(
          ApiErrorModel(
            message: message,
            icon: Icons.error,
            statusCode: res.statusCode ?? LocalStatusCodes.defaultError,
          ).toString(),
        );
      }
    } catch (e) {
      // rethrow;
      throw ServerException(
          ApiErrorFactory.defaultError('from remote data source').toString());
    }
  }
}
