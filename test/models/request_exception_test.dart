import 'package:biblioteca_network_sdk/src/models/request_exception.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const tStatusCode = 500;
  const tMessage = 'Error Message';
  final tStack = StackTrace.current;

  test('Create RequestException with main constructor', () {
    // Act
    final exception = RequestException(tStatusCode, tMessage, tStack);

    // Assert
    expect(exception.statusCode, tStatusCode);
    expect(exception.rawMessage, tMessage);
    expect(exception.stackTrace, tStack);
  });

  test('Create RequestException from json error', () {
    // Arrange
    const statusCode = 500;
    final stack = StackTrace.current;
    final errorJson = {
      'details': {
        'list': [1, 2, 3, 4, 5, 6],
        'test': true
      }
    };

    final json = {'message': 'Teste', 'error': errorJson};

    // Act
    final exception = RequestException.jsonError(statusCode, json, stack);

    // Assert
    expect(exception.rawMessage, json['message']);
    expect(exception.statusCode, statusCode);
    expect(exception.stackTrace, stack);
  });

  test('Create RequestException from json error with wrong data', () {
    // Arrange
    const statusCode = 500;
    final stack = StackTrace.current;
    final jsonError = {
      '_error': {
        'details': {
          'list': [1, 2, 3, 4, 5, 6],
          'test': true
        }
      }
    };

    // Act
    final exception = RequestException.jsonError(statusCode, jsonError, stack);

    // Assert
    expect(exception.rawMessage == null, true);
    expect(exception.statusCode, statusCode);
    expect(exception.stackTrace, stack);
  });

  test('RequestException to json', () {
    // Act
    final exception = RequestException(tStatusCode, tMessage, tStack).toJson();

    final expectedJson = {
      'statusCode': tStatusCode,
      'message': tMessage,
      'stackTrace': tStack.toString().split('\n')
    };

    // Assert
    expect(exception, expectedJson);
  });

  test('RequestException to string', () {
    // Act
    final exception =
        RequestException(tStatusCode, tMessage, tStack).toString();

    final expectedJson =
        '{statusCode: $tStatusCode, message: $tMessage, stackTrace: ${tStack.toString().split('\n')}}';

    // Assert
    expect(exception, expectedJson);
  });

  test('Test equals', () {
    // Arrange
    final stack = StackTrace.fromString('stackTraceString');
    final object1 = RequestException(tStatusCode, tMessage, stack);

    final object2 = RequestException(tStatusCode, tMessage, stack);

    // Assert
    expect(object1 == object2, isTrue);
  });

  test('Test not equals', () {
    // Arrange
    final object1 = RequestException(tStatusCode, tMessage, tStack);

    final object2 = RequestException(345, tMessage, tStack);

    // Assert
    expect(object1 == object2, isFalse);
  });
}
