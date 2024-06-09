import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query("country") String country = "us",
    @Query("apiKey") required String apiKey,
    @Query('category') required String category,
  });
}
