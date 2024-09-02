part of 'saved_news_cubit.dart';

abstract class SavedNewsState extends Equatable {
  const SavedNewsState();

  @override
  List<Object> get props => [];
}

class SavedNewsInitial extends SavedNewsState {}

class SavedNewsLoading extends SavedNewsState {}

class SavedNewsFailure extends SavedNewsState {}

class SavedNewsSuccess extends SavedNewsState {
  final List<HomeNewsModel> savedNews;
  const SavedNewsSuccess({required this.savedNews});

  @override
  List<Object> get props => [savedNews];
}


final class DeleteNewsLoading extends SavedNewsState {}

final class DeleteNewsFailure extends SavedNewsState {}

final class DeleteNewsSuccess extends SavedNewsState {
  //   final List<HomeNewsModel> savedNews;
  // const DeleteNewsSuccess({required this.savedNews});
}
