import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/bloc/articles/remote/remote_article_cubit.dart';
import 'package:news_app/features/news/presentation/screens/article_details.dart';
import 'package:news_app/features/news/presentation/widgets/feed_item.dart';
import 'package:news_app/viewmodel/feed/news_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data_layer/model/news.dart';

class FeedPage extends StatefulWidget {
  final String category;

  const FeedPage({super.key, required this.category});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<RemoteArticleCubit>(context).getNews(category: widget.category);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteArticleCubit, RemoteArticleState>(
        builder: (context, state) {
      if (state is RemoteArticleLoading) {
        return Center(
            child: CircularProgressIndicator(color: Colors.redAccent.shade400));
      }
      else if (state is RemoteArticleDone) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.separated(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailsActivity(
                    article: state.articles![index],
                    category: widget.category,
                    index: index,
                  ),
                ),
              ),
              child: FeedItem(article: state.articles![index], index: index),
            ),
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemCount: state.articles!.length,
          ),
        );
      }
      else if (state is RemoteArticleError) {
        return Center(child: Text('Error: ${state.error.toString()}'));
      }
      else {
        return Container(color: Colors.black);
      }
    });
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _news,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//               child:
//                   CircularProgressIndicator(color: Colors.redAccent.shade400));
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           return Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: ListView.separated(
//               itemBuilder: (context, index) => GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ArticleDetailsActivity(
//                       article: snapshot.data!.articles![index],
//                       category: widget.category,
//                       index: index,
//                     ),
//                   ),
//                 ),
//                 child: FeedItem(article: snapshot.data!.articles![index], index: index),
//               ),
//               separatorBuilder: (context, index) => const SizedBox(height: 12),
//               itemCount: snapshot.data!.articles!.length,
//             ),
//           );
//         }
//       },
//     );
//   }
// }
