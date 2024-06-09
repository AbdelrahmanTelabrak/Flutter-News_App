import 'package:news_app/features/news/domain/entities/article_entity.dart';

import '../../../../core/resources/data_state.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles({required String category});
}