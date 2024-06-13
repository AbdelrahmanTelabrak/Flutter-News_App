import 'package:news_app/features/news/domain/repository/article_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/article_entity.dart';

class GetSavedArticlesUseCase implements UseCase<List<ArticleEntity>, void> {

  final ArticleRepository _repo;

  GetSavedArticlesUseCase(this._repo);
  @override
  Future<List<ArticleEntity>> call({void params}) async {
    return _repo.getAllArticles();
  }

}