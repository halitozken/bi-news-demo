import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_project/models/articles.dart';

import '../models/news.dart';

class TechNewsService {
  static TechNewsService _singleton = TechNewsService._internal();
  TechNewsService._internal();

  factory TechNewsService() {
    return _singleton;
  }

  static Future<List<Articles>?> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=30d0fd65ad664fe18688a23a1553c980';

    final response = await http.get(Uri.parse(url));

    if (response.body.isNotEmpty) {
      final responseJson = jsonDecode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return null;
  }
}
