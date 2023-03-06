import 'dart:convert';
import 'dart:io';

enum JsonFiles {
  searchBooksResponse,
}

extension JsonFilesExtension on JsonFiles {
  get fileName {
    switch (this) {
      case JsonFiles.searchBooksResponse:
        return 'search_books_response.json';
    }
  }

  get path => 'test/responses/$fileName';

  get json async => await getJsonFromFile(path);
}

Future<Map<String, dynamic>> getJsonFromFile(String path) async {
  final file = File(path);
  return jsonDecode(await file.readAsString());
}
