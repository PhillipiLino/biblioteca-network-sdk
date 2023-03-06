import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/request_exception.dart';

extension DioErrorExtension on DioError {
  RequestException toException([StackTrace? stacktrace]) {
    if (this.response == null) {
      return RequestException(null, message, null, stacktrace);
    }

    var response = this.response;
    var statusCode = this.response?.statusCode ?? 0;
    var json = _decodeJsonString(response.toString());

    if (json == null) {
      return RequestException(
          statusCode, response.toString(), null, stacktrace);
    }

    return RequestException.jsonError(statusCode, json, stacktrace);
  }

  Map<String, dynamic>? _decodeJsonString(String jsonString) {
    try {
      var json = jsonDecode(jsonString);
      return json;
    } catch (e) {
      return null;
    }
  }
}
