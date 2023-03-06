import 'package:biblioteca_network_sdk/src/hosts.dart';

import '../../clients/client_interface.dart';
import '../../models/google_search_model.dart';
import 'requests/google_search_request.dart';

class GoogleService {
  IClient client;

  GoogleService(this.client);

  Future<GoogleSearchModel> searchBooks(GoogleSearchRequest request) async {
    final response = await client.get(
      'books/v1/volumes',
      queryParameters: request.parameters(),
      host: Host.google,
    );

    return GoogleSearchModel.fromJson(response);
  }
}
