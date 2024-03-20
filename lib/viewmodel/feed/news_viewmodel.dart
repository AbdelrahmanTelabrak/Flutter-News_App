import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/news.dart';

class NewsViewModel{

  Future<NewsModel> fetchNews(String category) async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=490bb5bbbbfa4d0ca6b5c7b90c7326e4"));
    return NewsModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

}