import 'package:http/http.dart' as http;
import 'dart:convert';

class AppNetwork {
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String> headers,
  }) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String body = response.body;
      Map<String, dynamic> data = json.decode(body);
      return data;
    } else {
      throw Exception('Server error');
    }
  }

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, String> headers,
    body,
  }) async {
    http.Response response = await http.post(url, body: body);

    if (response.statusCode == 201) {
      String body = response.body;
      Map<String, dynamic> data = json.decode(body);
      return data;
    } else {
      throw Exception('Server error');
    }
  }
}
