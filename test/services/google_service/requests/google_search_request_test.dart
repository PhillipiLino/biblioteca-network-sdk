import 'package:biblioteca_network_sdk/google_service.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const tTerm = 'term';
  const tStartIndex = 12;
  const tProjection = 'projection';
  const tMaxResults = 30;
  const tApiKey = 'key';

  test('Create google search request with main constructor', () {
    // Act
    const request = GoogleSearchRequest(
      term: tTerm,
      startIndex: tStartIndex,
      projection: tProjection,
      maxResults: tMaxResults,
      apiKey: tApiKey,
    );

    // Assert
    expect(request.term, tTerm);
    expect(request.startIndex, tStartIndex);
    expect(request.projection, tProjection);
    expect(request.maxResults, tMaxResults);
    expect(request.apiKey, tApiKey);
  });

  test('Transform google search request to parameters', () {
    // Act
    final request = const GoogleSearchRequest(
      term: tTerm,
      startIndex: tStartIndex,
      projection: tProjection,
      maxResults: tMaxResults,
      apiKey: tApiKey,
    ).parameters();

    final expectedJson = {
      'q': tTerm,
      'projection': tProjection,
      'maxResults': tMaxResults,
      'startIndex': tStartIndex,
      'key': tApiKey,
    };

    // Assert
    expect(request, expectedJson);
  });

  test('Test equals', () {
    // Arrange
    const request1 = GoogleSearchRequest(
      term: tTerm,
      startIndex: tStartIndex,
      projection: tProjection,
      maxResults: tMaxResults,
      apiKey: tApiKey,
    );

    const request2 = GoogleSearchRequest(
      term: tTerm,
      startIndex: tStartIndex,
      projection: tProjection,
      maxResults: tMaxResults,
      apiKey: tApiKey,
    );

    // Assert
    expect(request1 == request2, isTrue);
  });

  test('Test not equals', () {
    // Arrange
    const request1 = GoogleSearchRequest(
      term: tTerm,
      startIndex: tStartIndex,
      projection: tProjection,
      maxResults: tMaxResults,
      apiKey: tApiKey,
    );

    const request2 = GoogleSearchRequest(
      term: 'tUserEmail',
      startIndex: tStartIndex,
      projection: tProjection,
      maxResults: tMaxResults,
      apiKey: tApiKey,
    );

    // Assert
    expect(request1 == request2, isFalse);
  });
}
