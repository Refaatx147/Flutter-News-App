// ignore_for_file: must_be_immutable

part of 'category_news_bloc.dart';

// sealed class CategoryNewsState {}

// final class CategoryNewsInitial extends CategoryNewsState {}

// class CategorySuccessState extends CategoryNewsState{
//     final List<HomeNewsModel> categoryNews;

//   CategorySuccessState({required this.categoryNews});
// }

// class CategoryLoadingState extends CategoryNewsState{}

// class CategoryFailureState extends CategoryNewsState{
//   final String errorMessage;

//   CategoryFailureState({required this.errorMessage});

// }

enum CategoryNewsStatus {
  loading,
  success,
  error,
}

class CategoryNewsStates extends Equatable {
  final CategoryNewsStatus categoryStatus;
  final List<HomeNewsModel> categoryNewsList;
  final String categoryError;
  // int page;

  const CategoryNewsStates({
    this.categoryStatus =
        CategoryNewsStatus.loading, //can be changed to other status
    this.categoryNewsList = const [], // can be has data
    this.categoryError = '',
    //  this.page = 1} // can be has error
  });

  /// we will use a copyWith method to copy data with modifying selected fields
  CategoryNewsStates copyWith({
    CategoryNewsStatus? categoryStatus,
    final List<HomeNewsModel>? categoryNewsList,
    final String? categoryError,
    int? page,
  }) {
    return CategoryNewsStates(
      // default values will be which in the constructor of the class
      //nothing will come with nullable
      categoryStatus: categoryStatus ?? this.categoryStatus,
      categoryNewsList: categoryNewsList ?? this.categoryNewsList,
      categoryError: categoryError ?? this.categoryError,
      //   page: page ?? this.page);
    );
  }

  @override
  List<Object?> get props => [
        categoryStatus,
        categoryNewsList,
        categoryError,
      ];
}
