import 'package:http/http.dart';

class HttpAbstraction {
  const HttpAbstraction({required Client client}) : _client = client;

  final Client _client;

  Future<String> get(String url) async {
    final response = await _client.get(Uri.parse(url));
    return response.body;
  }
}