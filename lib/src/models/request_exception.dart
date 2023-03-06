import 'package:equatable/equatable.dart';

import 'response_error.dart';

class RequestException extends Equatable implements Exception {
  final int? statusCode;
  late final String message;
  final String? rawMessage;
  final ResponseError? error;
  final StackTrace? stackTrace;

  static const String _message = 'message';
  static const String _error = 'error';

  RequestException(
    this.statusCode,
    this.rawMessage,
    this.error,
    this.stackTrace,
  ) : message = _parseExceptionMessage(error, rawMessage);

  RequestException.jsonError(
    this.statusCode,
    Map<String, dynamic> json,
    this.stackTrace,
  )   : rawMessage = json.containsKey(_message) ? json[_message] : null,
        error = json.containsKey(_error)
            ? ResponseError.fromJson(json[_error])
            : null {
    message = _parseExceptionMessage(error, rawMessage);
  }

  static String _parseExceptionMessage(
    ResponseError? error,
    String? rawMessage,
  ) {
    final errorMessage = error?.messages?.first ?? rawMessage;
    if (error?.details is Map<String, dynamic>) {
      final errorMap = error?.details as Map<String, dynamic>;
      final firstKey = errorMap.keys.first;
      return '$firstKey $errorMessage';
    }

    return errorMessage ?? '';
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'message': rawMessage,
        'error': error.toString(),
        'stackTrace': stackTrace.toString().split('\n')
      };

  @override
  String toString() => '{statusCode: $statusCode, '
      'message: $rawMessage, '
      'error: $error, '
      'stackTrace: ${stackTrace.toString()}}';

  @override
  List<Object?> get props => [
        statusCode,
        message,
        rawMessage,
        error,
        stackTrace,
      ];
}
