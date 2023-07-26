import 'dart:async';

import 'package:http/http.dart' as http;

class HttpProvider {
  final http.Client client;

  HttpProvider({http.Client? client}) : client = client ?? http.Client();

  Future<String> get({
    required String url,
  }) async {
    final Uri? uri = Uri.tryParse(url);
    final http.Response response = await client.get(uri!);

    return response.body;
  }
}
