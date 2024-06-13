part of 'local_article_bloc.dart';

sealed class LocalArticleState extends Equatable {

  final List<ArticleEntity>? articles;
  const LocalArticleState({this.articles});

  @override
  List<Object> get props => [];

}

class LocalArticlesLoading extends LocalArticleState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticleState {
  const LocalArticlesDone(List<ArticleEntity> articles): super(articles: articles);
}