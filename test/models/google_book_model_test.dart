import 'package:biblioteca_network_sdk/models.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const tId = 'id';
  const tTitle = 'title';
  const tAuthors = ['authors'];
  const tPageCount = 10;
  const tImagePath = 'imagePath';

  test('Create model with main constructor', () {
    // Act
    const model = GoogleBookModel(
      id: tId,
      title: tTitle,
      authors: tAuthors,
      pageCount: tPageCount,
      imagePath: tImagePath,
    );

    // Assert
    expect(model.id, tId);
    expect(model.title, tTitle);
    expect(model.authors, tAuthors);
    expect(model.pageCount, tPageCount);
    expect(model.imagePath, tImagePath);
  });

  test('Create model from json', () {
    // Arrange
    final json = {
      'volumeInfo': {
        'title': tTitle,
        'pageCount': tPageCount,
        'authors': tAuthors,
        'imageLinks': {
          'thumbnail': tImagePath,
        }
      },
      'id': tId,
    };

    // Act
    final model = GoogleBookModel.fromJson(json);

    expect(model.id, tId);
    expect(model.title, tTitle);
    expect(model.authors, tAuthors);
    expect(model.pageCount, tPageCount);
    expect(model.imagePath, '$tImagePath&fife=w400-h600');
  });

  test('Transform model to json', () {
    // Act
    final model = const GoogleBookModel(
      id: tId,
      title: tTitle,
      authors: tAuthors,
      pageCount: tPageCount,
      imagePath: tImagePath,
    ).toJson();

    final expectedJson = {
      'id': tId,
      'title': tTitle,
      'authors': tAuthors,
      'pageCount': tPageCount,
      'imagePath': tImagePath,
    };

    // Assert
    expect(model, expectedJson);
  });

  test('Test equals', () {
    // Arrange
    const model1 = GoogleBookModel(
      id: tId,
      title: tTitle,
      authors: tAuthors,
      pageCount: tPageCount,
      imagePath: tImagePath,
    );

    const model2 = GoogleBookModel(
      id: tId,
      title: tTitle,
      authors: tAuthors,
      pageCount: tPageCount,
      imagePath: tImagePath,
    );

    // Assert
    expect(model1 == model2, isTrue);
  });

  test('Test not equals', () {
    // Arrange
    const model1 = GoogleBookModel(
      id: tId,
      title: tTitle,
      authors: tAuthors,
      pageCount: tPageCount,
      imagePath: tImagePath,
    );

    const model2 = GoogleBookModel(
      id: tId,
      title: tTitle,
      authors: [],
      pageCount: tPageCount,
      imagePath: tImagePath,
    );

    // Assert
    expect(model1 == model2, isFalse);
  });
}
