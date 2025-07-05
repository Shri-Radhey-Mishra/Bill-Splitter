import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://192.168.56.1:5000/api/splits';

  static Future<void> saveSplit(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/create');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      print('Request URL: $url');
      print('Request Body: ${jsonEncode(data)}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 201) {
        throw Exception('Failed to save split');
      }
    } catch (e) {
      print('Error during API call: $e');
    }
  }
}
