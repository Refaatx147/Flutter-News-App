part of 'category_news_bloc.dart';

sealed class CategoryNewsEvent {}

class CategoryEvent extends CategoryNewsEvent {
  final String category;

  CategoryEvent({required this.category});
}
