import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_saved_articles_usecase.dart';
import '../../../../domain/usecases/remove_article_usecase.dart';
import '../../../../domain/usecases/save_article_usecase.dart';

part 'local_article_event.dart';

part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticlesUseCase _getSavedArticlesUsecase;
  final RemoveArticleUsecase _removeArticleUsecase;
  final SaveArticleUsecase _saveArticleUsecase;

  LocalArticleBloc(
    this._getSavedArticlesUsecase,
    this._removeArticleUsecase,
    this._saveArticleUsecase,
  ) : super(const LocalArticlesLoading()){

    on<GetSavedArticles> (onGetSavedArticles);
    on<RemoveArticle> (onRemoveArticle);
    on<SaveArticle> (onSaveArticle);
  }

  void onGetSavedArticles(GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles));
  }

  void onRemoveArticle(RemoveArticle removeArticle, Emitter<LocalArticleState> emit) async {
    await _removeArticleUsecase.call(params: removeArticle.article);
    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle(SaveArticle saveArticle, Emitter<LocalArticleState> emit) async {
    await _saveArticleUsecase.call(params: saveArticle.article);
    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles));
  }

}
