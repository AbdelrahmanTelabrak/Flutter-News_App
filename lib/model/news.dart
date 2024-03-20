import 'articles.dart';

class NewsModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  NewsModel({this.status, this.totalResults, this.articles});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }
  //
  // factory NewsModel.fromJson(Map<String, dynamic> json) {
  //   return switch (json) {
  //     {
  //     'status': String status,
  //     'totalResults': int totalResults,
  //     'articles': List<Articles> articles,
  //     } =>
  //         NewsModel(
  //           status: status,
  //           totalResults: totalResults,
  //           articles: articles,
  //         ),
  //     _ => throw const FormatException('Failed to load news.'),
  //   };
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}