import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:news_appp/core/model/home_news_model/home_news_model.dart';
import 'package:news_appp/core/repositories/news_repository/news_repository.dart';

part 'home_news_event.dart';
part 'home_news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsStates> {
  // List<HomeNewsModel> news = [];
  NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(const NewsStates()) {
    on<HomeEvent>((event, emit) async {
      if (state.homeStatus == NewsStatus.loading) {
        emit(state.copyWith(homeStatus: NewsStatus.loading));
      }
      final response = await newsRepository.getNewsData(page: state.page);
      response.fold(
        (errorMessage) {
          emit(state.copyWith(
              homeError: errorMessage, homeStatus: NewsStatus.error));
        },
        (homeNews) {
          homeNews.isNotEmpty
              ? emit(state.copyWith(
                  homeNewsList: [...state.homeNewsList, ...homeNews],
                page: state.page + 1,
                  homeStatus: NewsStatus.success,
                ))
              : emit(state.copyWith(homeStatus: NewsStatus.success));
        },
      );
    }); // Adjust debounce ti);
  }
}
