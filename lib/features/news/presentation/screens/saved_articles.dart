import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/articles/local/local_article_bloc.dart';
import 'package:news_app/ui/widgets/texts.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/article_entity.dart';
import '../widgets/feed_item.dart';
import 'article_details.dart';

class SavedArticlesPage extends StatelessWidget {
  const SavedArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>()..add(const GetSavedArticles()),
      child: Scaffold(
        backgroundColor: const Color(0xff121212),
        appBar: AppBar(
          backgroundColor: const Color(0xff121212),
          title: boldText('Saved Articles', fontSize: 20, color: Colors.white),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: BlocBuilder<LocalArticleBloc, LocalArticleState>(
          builder: (context, state) {
            if (state is LocalArticlesLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ));
            } else if (state is LocalArticlesDone) {
              return _buildBody(state.articles!);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildBody(List<ArticleEntity> articles) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        itemBuilder: (context, index) => Dismissible(
          key: Key(articles[index].id!.toString()),
          onDismissed: (direction) {
            BlocProvider.of<LocalArticleBloc>(context)
                .add(RemoveArticle(article: articles[index]));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Color(0xff1E1E1E),
                content: Text('Article deleted successfully'),
              ),
            );
          },
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailsActivity(
                  article: articles[index],
                  category: '',
                  index: index,
                ),
              ),
            ),
            child: FeedItem(article: articles[index], index: index),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: articles.length,
      ),
    );
  }
}
