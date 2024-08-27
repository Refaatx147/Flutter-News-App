import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_appp/core/model/home_news_model/home_news_model.dart';
import 'package:news_appp/core/repositories/news_repository/news_repository.dart';

part 'category_news_event.dart';
part 'category_news_state.dart';

class CategoryNewsBloc extends Bloc<CategoryNewsEvent, CategoryNewsStates> {
  // List<HomeNewsModel> categoryNews = [];
  int catPage = 1;
  final NewsRepository newsRepository;
  CategoryNewsBloc(this.newsRepository) : super(const CategoryNewsStates()) {
    on<CategoryEvent>((event, emit) async {
// loading state
      if (state.categoryStatus == CategoryNewsStatus.loading) {
        emit(state.copyWith(categoryStatus: CategoryNewsStatus.loading));
      }
      final response = await newsRepository.getCategoryData(
          category: event.category, pageCategory: catPage++);
      response.fold(
          (errorMessage) => emit(state.copyWith(
              categoryError: errorMessage,
              categoryStatus: CategoryNewsStatus.error)), (categoryNews) {
        categoryNews.isNotEmpty
            ? emit((state.copyWith(
                categoryNewsList:
                    //List.of(state.categoryNewsList)
                    // ..addAll(categoryNews)
                    [...state.categoryNewsList, ...categoryNews],
                categoryStatus: CategoryNewsStatus.success,
              )))
            : emit(state.copyWith(categoryStatus: CategoryNewsStatus.success));
      });
    });
  }
}
