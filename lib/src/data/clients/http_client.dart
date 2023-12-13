import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url, Map<String, String>? headers});
}

class HttpClient implements IHttpClient {
  final client = http.Client(); // Instanciando o client

  @override
  Future get({required String url, Map<String, String>? headers}) async {
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    return response;
  }
}
