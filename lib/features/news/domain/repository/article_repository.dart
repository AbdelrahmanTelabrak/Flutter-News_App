import 'package:news_app/features/news/domain/entities/article_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/article_model.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles({required String category});

  Future<void> insertArticle(ArticleEntity article);
  Future<void> deleteArticle(ArticleEntity article);
  Future<List<ArticleEntity>> getAllArticles();
}