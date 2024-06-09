import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/news/domain/repository/article_repository.dart';

import 'features/news/data/repository/article_repository.dart';
import 'features/news/domain/usecases/get_article_usecase.dart';
import 'features/news/presentation/bloc/articles/remote/remote_article_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio instance
  sl.registerSingleton<Dio>(
    Dio(),
  );

  // Dependencies
  sl.registerSingleton<NewsApiService>(
    NewsApiService(sl()),
  );

  sl.registerSingleton<ArticleRepository>(
    ArticleRepoImpl(sl()),
  );

  // UseCases
  sl.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<RemoteArticleCubit>(
    () => RemoteArticleCubit(sl<GetArticleUseCase>()),
  );
}
