import 'package:equatable/equatable.dart';

class ResponseError extends Equatable {
  final dynamic details;
  final List<String>? messages;

  static const String _details = 'details';

  ResponseError({this.details}) : messages = _getMessages(details);

  ResponseError.fromJson(Map<String, dynamic> json)
      : details = json[_details],
        messages = _getMessages(json[_details]);

  static List<String>? _getMessages(dynamic details) {
    List<String>? messages;
    if (details is String) {
      messages = [details];
      return messages;
    }

    if (details is Map<String, dynamic>?) {
      messages = details?.values.fold(<String>[], (List<String> old, value) {
        final newResult = [...old];

        if (value is List) {
          final newValues = value.map((e) => e.toString());
          newResult.addAll(newValues);
          return newResult;
        }

        if (value is Map<String, dynamic>?) {
          final mapValue = value;

          List<String> mapValues = mapValue?.values.expand((nestedValue) {
                if (nestedValue is! List) {
                  return <String>[nestedValue.toString()];
                }

                return nestedValue.map((e) => e.toString());
              }).toList() ??
              [];

          newResult.addAll(mapValues);
          return newResult;
        }

        newResult.add(value.toString());
        return newResult;
      }).toList();

      return messages;
    }

    if (details is List?) {
      messages = details?.map((e) => e.toString()).toList();
      return messages;
    }

    messages = [details.toString()];
    return messages;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[_details] = details;
    return data;
  }

  @override
  List<Object?> get props => [
        details,
        messages,
      ];
}
