import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  // Using a free public API that doesn't require authentication
  static const String baseUrl = 'https://saurav.tech/NewsAPI/top-headlines/category/technology/us.json';

  Future<List<NewsArticle>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'] ?? [];

        return articles
            .map((article) => NewsArticle.fromJson(article))
            .take(10) // Limit to 10 articles
            .toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
