import 'package:equatable/equatable.dart';

class GoogleSearchRequest extends Equatable {
  final String term;
  final String? projection;
  final int? maxResults;
  final int? startIndex;
  final String? apiKey;

  static const _term = 'q';
  static const _projection = 'projection';
  static const _maxResults = 'maxResults';
  static const _startIndex = 'startIndex';
  static const _apiKey = 'key';

  const GoogleSearchRequest({
    required this.term,
    required this.startIndex,
    this.projection = 'full',
    this.maxResults = 20,
    this.apiKey,
  });

  Map<String, dynamic> parameters() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json[_term] = term;
    json[_projection] = projection;
    json[_maxResults] = maxResults;
    json[_startIndex] = startIndex;
    json[_apiKey] = apiKey;

    json.removeWhere((key, value) => value == null);
    return json;
  }

  @override
  List<Object?> get props => [
        term,
        projection,
        maxResults,
        startIndex,
        apiKey,
      ];
}
