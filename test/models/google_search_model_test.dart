import 'package:biblioteca_network_sdk/models.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const tKind = 'kind';
  const tTotalItems = 2;
  const tBookModel = GoogleBookModel(
    id: 'id',
    title: 'title',
    authors: [],
    pageCount: 2,
    imagePath: 'image',
  );

  final List<GoogleBookModel> tItems = [tBookModel];

  test('Create model with main constructor', () {
    // Act
    final model = GoogleSearchModel(
      kind: tKind,
      totalItems: tTotalItems,
      items: tItems,
    );

    // Assert
    expect(model.kind, tKind);
    expect(model.totalItems, tTotalItems);
    expect(model.items, tItems);
  });

  test('Create model from json', () {
    // Arrange
    final json = {
      'kind': tKind,
      'totalItems': tTotalItems,
      'items': [
        {
          'volumeInfo': {
            'title': tBookModel.title,
            'pageCount': tBookModel.pageCount,
            'authors': tBookModel.authors,
            'imageLinks': {
              'thumbnail': tBookModel.imagePath,
            }
          },
          'id': tBookModel.id,
        }
      ],
    };

    // Act
    final model = GoogleSearchModel.fromJson(json);
    final tBook = GoogleBookModel(
      id: tBookModel.id,
      title: tBookModel.title,
      authors: tBookModel.authors,
      pageCount: tBookModel.pageCount,
      imagePath: '${tBookModel.imagePath}&fife=w400-h600',
    );

    expect(model.kind, tKind);
    expect(model.totalItems, tTotalItems);
    expect(model.items, [tBook]);
  });

  test('Transform model to json', () {
    // Act
    final model = GoogleSearchModel(
      kind: tKind,
      totalItems: tTotalItems,
      items: tItems,
    ).toJson();

    final expectedJson = {
      'kind': tKind,
      'totalItems': tTotalItems,
      'items': tItems.map((e) => e.toJson()),
    };

    // Assert
    expect(model, expectedJson);
  });

  test('Test equals', () {
    // Arrange
    final model1 = GoogleSearchModel(
      kind: tKind,
      totalItems: tTotalItems,
      items: tItems,
    );

    final model2 = GoogleSearchModel(
      kind: tKind,
      totalItems: tTotalItems,
      items: tItems,
    );

    // Assert
    expect(model1 == model2, isTrue);
  });

  test('Test not equals', () {
    // Arrange
    final model1 = GoogleSearchModel(
      kind: tKind,
      totalItems: tTotalItems,
      items: tItems,
    );

    const model2 = GoogleSearchModel(
      kind: tKind,
      totalItems: tTotalItems,
      items: null,
    );

    // Assert
    expect(model1 == model2, isFalse);
  });
}
