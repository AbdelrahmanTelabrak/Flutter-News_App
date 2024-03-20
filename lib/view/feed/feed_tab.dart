import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/view/article_details.dart';
import 'package:news_app/view/feed/feed_item.dart';
import 'package:news_app/viewmodel/feed/news_viewmodel.dart';

class FeedPage extends StatefulWidget {
  final String category;

  const FeedPage({super.key, required this.category});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late Future<NewsModel> _news;

  @override
  void initState() {
    super.initState();
    _news = NewsViewModel().fetchNews(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _news,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  CircularProgressIndicator(color: Colors.redAccent.shade400));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailsActivity(
                      article: snapshot.data!.articles![index],
                      category: widget.category,
                      index: index,
                    ),
                  ),
                ),
                child: FeedItem(article: snapshot.data!.articles![index], index: index),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: snapshot.data!.articles!.length,
            ),
          );
        }
      },
    );
  }
}
