import 'package:biblioteca_network_sdk/src/helpers/dio_error_extensions.dart';
import 'package:biblioteca_network_sdk/src/helpers/request_log_event_helper.dart';
import 'package:biblioteca_network_sdk/src/models/request_exception.dart';
import 'package:commons_tools_sdk/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Create event using dio request', () {
    // Arrange
    final options = RequestOptions(
        path: 'path_test',
        method: 'POST',
        headers: {'header': true},
        baseUrl: '');

    // Act
    final event = RequestLogEventExtension.fromDioRequest(options);

    final expectedJson = {
      'url': options.path,
      'data': options.data,
      'method': options.method,
      'headers': options.headers,
      'contentType': options.contentType,
      'queryParameters': options.queryParameters,
      'response': null,
      'statusCode': null,
      'exception': null.toString(),
    };

    final expectedString = '---- EVENT INFORMATIONS ----'
        '\nurl: ${options.path}'
        '\ndata: ${options.data}'
        '\nmethod: ${options.method}'
        '\nheaders: ${options.headers}'
        '\ncontentType: ${options.contentType}'
        '\nqueryParameters: ${options.queryParameters}'
        '\nstatusCode: null'
        '\nexception: null'
        '\nresponse: null';

    // Assert
    expect(event.url, options.path);
    expect(event.method, options.method);
    expect(event.data, options.data);
    expect(event.headers, options.headers);
    expect(event.contentType, options.contentType);
    expect(event.queryParameters, options.queryParameters);
    expect(event.exception, null);
    expect(event.response, null);
    expect(event.logType, LogType.request);
    expect(event.toJson(), expectedJson);
    expect(event.toString(), expectedString);
  });

  test('Create event using dio error', () {
    // Arrange
    final options = RequestOptions(
      path: 'path_test',
      method: 'POST',
      headers: {'header': true},
    );

    final response = Response(
      requestOptions: options,
      data: {
        'message': 'Request error',
        'error': {'details': false}
      },
      statusCode: 500,
    );

    final error =
        DioError(requestOptions: options, error: 'Teste', response: response);

    // Act
    final event = RequestLogEventExtension.fromDioError(error);

    final exception = error.toException();

    final expectedJson = {
      'url': options.path,
      'data': options.data,
      'method': options.method,
      'headers': options.headers,
      'contentType': options.contentType,
      'queryParameters': options.queryParameters,
      'statusCode': 500,
      'response': null,
      'exception': exception.toString(),
    };

    final expectedString = '---- EVENT INFORMATIONS ----'
        '\nurl: ${options.path}'
        '\ndata: ${options.data}'
        '\nmethod: ${options.method}'
        '\nheaders: ${options.headers}'
        '\ncontentType: ${options.contentType}'
        '\nqueryParameters: ${options.queryParameters}'
        '\nstatusCode: 500'
        '\nexception: $exception'
        '\nresponse: null';

    // Assert
    expect(event.url, options.path);
    expect(event.method, options.method);
    expect(event.data, options.data);
    expect(event.headers, options.headers);
    expect(event.contentType, options.contentType);
    expect(event.queryParameters, options.queryParameters);
    expect(event.exception is RequestException, true);
    expect(event.response, null);
    expect(event.logType, LogType.error);
    expect(
        (event.exception as RequestException).rawMessage, exception.rawMessage);
    expect(event.toJson(), expectedJson);
    expect(event.toString(), expectedString);
  });

  test('Create event using dio response', () {
    // Arrange
    final options = RequestOptions(
      path: 'path_test',
      method: 'POST',
      headers: {'header': true},
    );

    final response = Response(
      requestOptions: options,
      data: {
        'message': 'Request success',
        'error': {'details': false}
      },
      statusCode: 200,
    );

    // Act
    final event = RequestLogEventExtension.fromDioResponse(response);

    final expectedJson = {
      'url': options.path,
      'data': options.data,
      'method': options.method,
      'headers': options.headers,
      'contentType': options.contentType,
      'queryParameters': options.queryParameters,
      'response': response.data,
      'statusCode': 200,
      'exception': null.toString(),
    };

    final expectedString = '---- EVENT INFORMATIONS ----'
        '\nurl: ${options.path}'
        '\ndata: ${options.data}'
        '\nmethod: ${options.method}'
        '\nheaders: ${options.headers}'
        '\ncontentType: ${options.contentType}'
        '\nqueryParameters: ${options.queryParameters}'
        '\nstatusCode: 200'
        '\nexception: null'
        '\nresponse: ${response.data}';

    // Assert
    expect(event.url, options.path);
    expect(event.method, options.method);
    expect(event.data, options.data);
    expect(event.headers, options.headers);
    expect(event.contentType, options.contentType);
    expect(event.queryParameters, options.queryParameters);
    expect(event.response, response.data);
    expect(event.exception, null);
    expect(event.logType, LogType.responseRequest);
    expect(event.toJson(), expectedJson);
    expect(event.toString(), expectedString);
  });
}
