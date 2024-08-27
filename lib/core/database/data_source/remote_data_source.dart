import 'package:news_appp/core/api/api_consumer.dart';
import 'package:news_appp/core/api/end_points.dart';
import 'package:news_appp/core/errors/exceptions.dart';
import 'package:news_appp/core/model/home_news_model/home_news_model.dart';

class RemoteDataSource {
  final ApiConsumer apiConsumer;

  RemoteDataSource(this.apiConsumer);

  Future<List<HomeNewsModel>> getNewsData({int? page}) async {
    try {
      // Make the API call
      final response = await apiConsumer.get(
        // EndPoints.headLineEndPoint,
        //   queryParameters: EndPoints.queryNews(page: page ?? 1
        EndPoints.url,
        queryParameters: EndPoints.query(page: page?? 1)
          );
          //  EndPoints.url
          

      // Access the 'articles' part of the response
      // Map the articles to a list of HomeNewsModel objects
      final List<HomeNewsModel> news = response['data']
          .map<HomeNewsModel>((item) => HomeNewsModel.fromJson(item))
          .toList();

      return news;
    } on ServerException catch (e) {
      throw ServerException(errorModel: e.errorModel);
    }
  }

  Future<List<HomeNewsModel>> getCategoryData(
      {required String category, int? page}) async {
    try {
      // Make the API call
      final response = await apiConsumer.get(EndPoints.url,
          queryParameters:
              EndPoints.query(category: category, page: page ?? 1)
          //  EndPoints.url
          );

      // Access the 'articles' part of the response
      // Map the articles to a list of HomeNewsModel objects
      final List<HomeNewsModel> categoryNews = response['data']
          .map<HomeNewsModel>((item) => HomeNewsModel.fromJson(item))
          .toList();

      return categoryNews;
    } on ServerException catch (e) {
      throw ServerException(errorModel: e.errorModel);
    }
  }
}
