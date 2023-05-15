import 'dart:convert';
import 'package:http/http.dart' as http;

class BookApiProvider {
  Future<List<dynamic>> searchBooks(String query) async {
    final response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['items'];
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<dynamic>> getBooks(String query) async {
    final response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['items'];
    } else {
      throw Exception('Failed to load books');
    }
  }
}
