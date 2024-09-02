import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_appp/core/database/data_source/local_data_source.dart';
import 'package:news_appp/core/model/home_news_model/home_news_model.dart';

part 'saved_news_state.dart';

class SavedNewsCubit extends Cubit<SavedNewsState> {
  SavedNewsCubit(this.localDataSource, {required this.savedNews})
      : super(SavedNewsInitial()) {
    getSavedNews();
  }
  LocalDataSource localDataSource;
  List<HomeNewsModel> savedNews;
  bool repeated = true;

  Future saveNew(HomeNewsModel savedNew) async {
    emit(SavedNewsLoading());

    try {
      // Check for duplicate before adding
      if (!savedNews.contains(savedNew)) {
        repeated = false;
        print('Saving News: ${savedNew.toJson()}');
        savedNews.add(savedNew);
        await localDataSource.saveNews(savedNews);
      }
      repeated = true;
      emit(SavedNewsSuccess(savedNews: savedNews));
      print('savedNews => ${savedNews.length}');
      print(savedNews);
      //   return (savedNews);
    } on Exception catch (error) {
      emit(SavedNewsFailure());
      return (error.toString());
    }
  }

  Future getSavedNews() async {
    emit(SavedNewsLoading());
    try {
      final news = await localDataSource.getSavedNews();
      savedNews = news;
      print('$savedNews');
      emit(SavedNewsSuccess(savedNews: savedNews));
      // return (savedNews);
    } on Exception catch (error) {
      emit(SavedNewsFailure());
      return (error.toString());
    }
  }

  Future deleteNew(HomeNewsModel deletedNew) async {
    emit(DeleteNewsLoading());

    try {
      await localDataSource.deleteSavedArticle(deletedNew);
      await Future.delayed(const Duration(seconds: 2));

      emit(DeleteNewsSuccess());

      // Fetch the updated list of saved news
      final updatedNews = await localDataSource.getSavedNews();
      savedNews = updatedNews;
      emit(SavedNewsSuccess(savedNews: savedNews));
    } on Exception catch (error) {
      emit(DeleteNewsFailure());
      return (error.toString());
    }
  }
}
