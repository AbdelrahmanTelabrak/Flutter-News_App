part of 'remote_article_cubit.dart';

@immutable
sealed class RemoteArticleState extends Equatable{
  final List<ArticleEntity>? articles;
  final DioError? error;

  const RemoteArticleState({this.articles, this.error});

  @override
  List<Object?> get props => [articles, error];
}

final class RemoteArticleInitial extends RemoteArticleState {
  const RemoteArticleInitial();
}

final class RemoteArticleLoading extends RemoteArticleState {
  const RemoteArticleLoading();
}

final class RemoteArticleDone extends RemoteArticleState {
  const RemoteArticleDone(List<ArticleEntity> articles) : super(articles: articles);
}

final class RemoteArticleError extends RemoteArticleState {
  const RemoteArticleError(DioError error) : super(error: error);
}
