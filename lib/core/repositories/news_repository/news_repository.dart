import 'package:dartz/dartz.dart';
import 'package:news_appp/core/database/data_source/local_data_source.dart';
import 'package:news_appp/core/database/data_source/remote_data_source.dart';
import 'package:news_appp/core/errors/exceptions.dart';
import 'package:news_appp/core/model/home_news_model/home_news_model.dart';

class NewsRepository {
  // final ApiConsumer apiConsumer;
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  NewsRepository(this.localDataSource, this.remoteDataSource);

  Future<Either<String, List<HomeNewsModel>>> getNewsData({int? page}) async {
    try {
      final homeNews = await localDataSource.getHomeNews();
      if (homeNews.isNotEmpty && page == 1) {
              print("HomeNews is came from local");

        return Right(homeNews);
      } else {
                print("page number => $page");

        final remoteHomeNews = await remoteDataSource.getNewsData(page: page);
        if (page == 1) {
          localDataSource.saveHomeNews(remoteHomeNews);
        }
        return Right(remoteHomeNews);
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage ?? "there an error in connection");
    }
  }

  Future<Either<String, List<HomeNewsModel>>> getCategoryData(
      {required String category, int? pageCategory}) async {
    try {
     final categoryNews = await localDataSource.getCategoryNews(category);
      if (categoryNews.isNotEmpty && pageCategory == 1) {
                      print("categoryNews is came from local");

        return Right(categoryNews);
      } else {
        print("page number => $pageCategory");
        final remoteCategoryNews = await remoteDataSource.getCategoryData(
            page: pageCategory, category: category);
        if (pageCategory == 1) {
          localDataSource.saveCategoryNews(remoteCategoryNews, category);
        }

        return Right(remoteCategoryNews);
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage ?? "there an error in connection");
    }
  }
}
