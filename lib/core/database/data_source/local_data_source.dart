import 'dart:convert';
import 'package:news_appp/core/app_constants/app_strings.dart';
import 'package:news_appp/core/database/cache/cache_helper.dart';
import 'package:news_appp/core/model/home_news_model/home_news_model.dart';

class LocalDataSource {
  // will cache our List<HomeNewsModel>

// here this function cached our data
  Future<void> saveHomeNews(List<HomeNewsModel> news) async {
    // first we will encode our data
    List home = news
        .map<Map<String, dynamic>>((homeNews) => homeNews.toJson())
        .toList();

    await CacheHelper()
        .saveData(key: AppStrings.cacheHome, value: jsonEncode(home));
  }

// Get our home data
  Future<List<HomeNewsModel>> getHomeNews() async {
    final homeNews = await CacheHelper().getData(key: AppStrings.cacheHome);
    if (homeNews != null) {
      List<HomeNewsModel> list = (jsonDecode(homeNews) as List)
          .map((home) => HomeNewsModel.fromJson(home))
          .toList();

      return Future.value(list);
    } else {
      return [];
    }
  }

// here this function cached our data
  Future<void> saveCategoryNews(
      List<HomeNewsModel> categoryNews, String category) async {
    // first we will encode our data
    List home = categoryNews
        .map<Map<String, dynamic>>((categoryNews) => categoryNews.toJson())
        .toList();

    await CacheHelper().saveData(key: category, value: jsonEncode(home));
  }

// Get our home data
  Future<List<HomeNewsModel>> getCategoryNews(String category) async {
    final categoryNews = await CacheHelper().getData(key: category);
    if (categoryNews != null) {
      List<HomeNewsModel> list = (jsonDecode(categoryNews) as List)
          .map((categoryNew) => HomeNewsModel.fromJson(categoryNew))
          .toList();

      return Future.value(list);
    } else {
      return [];
    }
  }

  Future<void> saveNews(List<HomeNewsModel> news) async {
    List savedNews = news
        .map<Map<String, dynamic>>((homeNews) => homeNews.toJson())
        .toList();

    await CacheHelper()
        .saveData(key: AppStrings.cacheSaved, value: jsonEncode(savedNews));
  }

  Future<List<HomeNewsModel>> getSavedNews() async {
    final savedNews = await CacheHelper().getData(key: AppStrings.cacheSaved);
    if (savedNews != null) {
      List<HomeNewsModel> list = (jsonDecode(savedNews) as List)
          .map((saved) => HomeNewsModel.fromJson(saved))
          .toList();

      return Future.value(list);
    } else {
      return [];
    }
  }

  // Future deleteSavedNews() async {
  //   await CacheHelper().removeData(key: AppStrings.cacheSaved);
  // }

// Add this method to your LocalDataSource class
  Future<void> deleteSavedArticle(HomeNewsModel article) async {
    // Get current saved articles from cache
    final savedNews = await getSavedNews();

    // Remove the article from the list
    savedNews.removeWhere((deletedNew) =>
        deletedNew.uuid == article.uuid); // assuming 'id' is a unique identifier

    // Save the updated list back to cache
    await saveNews(savedNews);
  }
}
