part of 'home_layout_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeChangeMode extends HomeState {}

final class LayoutChangePage extends HomeState {}

