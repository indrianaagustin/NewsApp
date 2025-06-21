import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  final String apiKey = 'f9efe20a85ca4fe7913f8832cd2503ac';

  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=id&apiKey=$apiKey',
    ));

    print('Status Code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List articles = json['articles'];
      print('Jumlah artikel: ${articles.length}');
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Gagal load berita: ${response.statusCode}');
    }
  }
}