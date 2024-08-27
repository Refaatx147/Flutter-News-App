part of 'home_news_bloc.dart';

enum NewsStatus {
  loading,
  success,
  error,
}

class NewsStates extends Equatable{
  final NewsStatus homeStatus;
  final List<HomeNewsModel> homeNewsList;
  final String homeError;
  final int page;

 const NewsStates(
      {this.homeStatus = NewsStatus.loading, //can be changed to other status
      this.homeNewsList = const [], // can be has data
      this.homeError = '',
      this.page =1,} // can be has error
      );

  /// we will use a copyWith method to copy data with modifying selected fields
  NewsStates copyWith({
    NewsStatus? homeStatus,
  final List<HomeNewsModel>? homeNewsList,
    final String? homeError,
    final int? page,
  }) {
    return NewsStates(
      // default values will be which in the constructor of the class
      //nothing will come with nullable
      homeStatus: homeStatus ?? this.homeStatus,
      homeNewsList: homeNewsList ?? this.homeNewsList,
      homeError: homeError ?? this.homeError,
      page: page?? this.page
    );
  }
  
  @override
  List<Object?> get props => [
    homeStatus,
    homeNewsList,
    homeError,
  ];
}
