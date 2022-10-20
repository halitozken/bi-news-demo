import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_project/models/articles.dart';

import '../models/news.dart';

class HealthNewsService {
  static HealthNewsService _singleton = HealthNewsService._internal();
  HealthNewsService._internal();

  factory HealthNewsService() {
    return _singleton;
  }

  static Future<List<Articles>?> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=30d0fd65ad664fe18688a23a1553c980';

    final response = await http.get(Uri.parse(url));

    if (response.body.isNotEmpty) {
      final responseJson = jsonDecode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return null;
  }
}
