import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/news/domain/repository/article_repository.dart';

import 'features/news/data/data_sources/local/app_database.dart';
import 'features/news/data/repository/article_repository.dart';
import 'features/news/domain/usecases/get_article_usecase.dart';
import 'features/news/domain/usecases/get_saved_articles_usecase.dart';
import 'features/news/domain/usecases/remove_article_usecase.dart';
import 'features/news/domain/usecases/save_article_usecase.dart';
import 'features/news/presentation/bloc/articles/remote/remote_article_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  // Dio instance
  sl.registerSingleton<Dio>(
    Dio(),
  );

  // Dependencies
  sl.registerSingleton<NewsApiService>(
    NewsApiService(sl()),
  );

  sl.registerSingleton<ArticleRepository>(
    ArticleRepoImpl(sl(), sl<AppDatabase>()),
  );

  // UseCases
  sl.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(sl()),
  );

  sl.registerSingleton<SaveArticleUsecase>(
    SaveArticleUsecase(sl()),
  );

  sl.registerSingleton<RemoveArticleUsecase>(
    RemoveArticleUsecase(sl()),
  );

  sl.registerSingleton<GetSavedArticlesUseCase>(
    GetSavedArticlesUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<RemoteArticleCubit>(
    () => RemoteArticleCubit(sl<GetArticleUseCase>()),
  );
}
