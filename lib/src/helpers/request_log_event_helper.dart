import 'package:biblioteca_sdk/src/helpers/dio_error_extensions.dart';
import 'package:commons_tools_sdk/logger.dart';
import 'package:dio/dio.dart';

extension RequestLogEventExtension on RequestLogEvent {
  static RequestLogEvent fromDioRequest(RequestOptions options) =>
      RequestLogEvent(
        url: options.baseUrl + options.path,
        method: options.method,
        data: options.data,
        headers: options.headers,
        contentType: options.contentType,
        queryParameters: options.queryParameters,
        statusCode: null,
        exception: null,
        response: null,
        logType: LogType.request,
      );

  static RequestLogEvent fromDioError(
    DioError error, [
    StackTrace? stackTrace,
  ]) =>
      RequestLogEvent(
        url: error.requestOptions.baseUrl + error.requestOptions.path,
        method: error.requestOptions.method,
        data: error.requestOptions.data,
        headers: error.requestOptions.headers,
        contentType: error.requestOptions.contentType,
        queryParameters: error.requestOptions.queryParameters,
        response: null,
        statusCode: error.response?.statusCode,
        exception: error.toException(stackTrace),
        logType: LogType.error,
      );

  static RequestLogEvent fromDioResponse(Response response) => RequestLogEvent(
        url: response.requestOptions.baseUrl + response.requestOptions.path,
        method: response.requestOptions.method,
        data: response.requestOptions.data,
        headers: response.requestOptions.headers,
        contentType: response.requestOptions.contentType,
        queryParameters: response.requestOptions.queryParameters,
        response: response.data,
        statusCode: response.statusCode,
        exception: null,
        logType: LogType.responseRequest,
      );
}
