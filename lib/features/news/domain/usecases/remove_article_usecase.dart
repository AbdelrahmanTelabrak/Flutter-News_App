import 'package:news_app/features/news/domain/entities/article_entity.dart';

import '../../../../core/usecases/usecase.dart';
import '../repository/article_repository.dart';

class RemoveArticleUsecase implements UseCase<void, ArticleEntity> {

  final ArticleRepository _repo;
  RemoveArticleUsecase(this._repo);
  @override
  Future<void> call({ArticleEntity? params}) {
    return _repo.deleteArticle(params!);
  }

}