import 'dart:io';

import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';
import 'package:news_app/features/news/domain/repository/article_repository.dart';

import 'package:dio/dio.dart';

import '../data_sources/local/app_database.dart';

class ArticleRepoImpl implements ArticleRepository {
  final NewsApiService newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepoImpl(this.newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles(
      {required String category}) async {
    try {
      final httpResponse = await newsApiService.getNewsArticles(
        apiKey: apiKey,
        category: category,
        country: apiCountry,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> deleteArticle(ArticleEntity article) async {
    return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<List<ArticleEntity>> getAllArticles() async {
    return _appDatabase.articleDao.getAllArticles();
  }

  @override
  Future<void> insertArticle(ArticleEntity article) async {
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
}
