import 'package:equatable/equatable.dart';

class RequestException extends Equatable implements Exception {
  final int? statusCode;
  final String? rawMessage;
  final StackTrace? stackTrace;

  static const String _message = 'message';

  const RequestException(
    this.statusCode,
    this.rawMessage,
    this.stackTrace,
  );

  RequestException.jsonError(
    this.statusCode,
    Map<String, dynamic> json,
    this.stackTrace,
  ) : rawMessage = json.containsKey(_message) ? json[_message] : null;

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'message': rawMessage,
        'stackTrace': stackTrace.toString().split('\n')
      };

  @override
  String toString() => toJson().toString();

  @override
  List<Object?> get props => [
        statusCode,
        rawMessage,
        stackTrace,
      ];
}
