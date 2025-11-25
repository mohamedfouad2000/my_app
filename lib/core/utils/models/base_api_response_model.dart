import 'dart:convert';

import 'package:my_app/core/errors/exceptions.dart';
import 'package:my_app/core/utils/models/meta_model.dart';

class BaseApiResponseModel {
  BaseApiResponseModel({
    // this.success,
    this.data,
    this.meta,
    // this.errors = const [],
  });

  factory BaseApiResponseModel.fromJson(String source) {
    try {
      return BaseApiResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
  BaseApiResponseModel.fromMap(Map<String, dynamic> json) {
    // success = json['code'] == 200 || json['status'] == true;
    data = json['data'];
    // msg = json['message'];
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
    // code = json['code'];
    // errors = json['meta'] != null ? json['meta']['errors'] : [];
  }
  // bool? success;
  dynamic data;
  // String? msg;
  MetaModel? meta;
  // int? code;
  // List<String> errors = [];
}
