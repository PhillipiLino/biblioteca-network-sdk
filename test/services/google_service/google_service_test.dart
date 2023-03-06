import 'package:biblioteca_network_sdk/google_service.dart';
import 'package:biblioteca_network_sdk/src/hosts.dart';
import 'package:biblioteca_network_sdk/src/models/google_search_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../client_mock.dart';
import '../../responses/json_manager.dart';

main() {
  final client = ClientMock();
  final service = GoogleService(client);

  const tRequest = GoogleSearchRequest(term: 'term', startIndex: 0);

  setUp(() {
    registerFallbackValue(Host.undefined);
  });

  test('Search books at google service', () async {
    // Arrange
    when(() => client.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          host: any(named: 'host'),
        )).thenAnswer((_) async => JsonFiles.searchBooksResponse.json);

    // Act
    final response = await service.searchBooks(tRequest);

    // Assert
    expect(response, isNotNull);
    expect(response, isA<GoogleSearchModel>());
    verify(() => client.get(
          'books/v1/volumes',
          queryParameters: tRequest.parameters(),
          host: Host.google,
        )).called(1);
  });

  test('Search books at google service with wrong json response', () async {
    // Arrange
    when(() => client.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          host: any(named: 'host'),
        )).thenAnswer((_) async => {});

    // Act
    final response = await service.searchBooks(tRequest).catchError((error) {
      expect(error != null, true);
      return null;
    });

    // Assert
    expect(response == null, true);
  });

  test('Search books at google service with error', () async {
    // Arrange
    when(() => client.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          host: any(named: 'host'),
        )).thenThrow((_) => Exception());

    // Act
    final response = await service.searchBooks(tRequest).catchError((error) {
      expect(error != null, true);
      return null;
    });

    // Assert
    expect(response == null, true);
  });
}
