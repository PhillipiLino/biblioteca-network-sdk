import 'package:biblioteca_network_sdk/src/helpers/dio_error_extensions.dart';
import 'package:biblioteca_network_sdk/src/models/request_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Convert dioError without response', () {
    final error = DioError(
        requestOptions: RequestOptions(path: 'path_test'), error: 'Teste');

    final exception = error.toException();

    const expectedString = '{statusCode: null, '
        'message: Teste, '
        'stackTrace: [null]}';

    expect(exception, isA<RequestException>());
    expect(exception.toString(), expectedString);
  });

  test('Convert dioError with response without json error', () {
    final options = RequestOptions(path: 'path_test');
    final response =
        Response(requestOptions: options, data: 'Error Data', statusCode: 500);
    final error =
        DioError(requestOptions: options, error: 'Teste', response: response);

    final exception = error.toException();

    expect(exception, isA<RequestException>());
    expect(exception.statusCode, 500);
    expect(exception.rawMessage, 'Error Data');
  });

  test('Convert dioError with response with json error', () {
    final options = RequestOptions(path: 'path_test');
    final response = Response(
        requestOptions: options,
        data: {
          'message': 'Request error',
          'error': {'details': false}
        },
        statusCode: 500);
    final error =
        DioError(requestOptions: options, error: 'Teste', response: response);

    final exception = error.toException();

    expect(exception.statusCode, 500);
    expect(exception.rawMessage, 'Request error');
  });
}
