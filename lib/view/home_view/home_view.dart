// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_appp/core/blocs/api_bloc/home_news_bloc/home_news_bloc.dart';
import 'package:news_appp/view/widgets/alert_error.dart';
import 'package:news_appp/view/widgets/list_widget.dart';
import 'package:news_appp/view/widgets/loading_widget.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsStates>(
        buildWhen: ((previous, current) => previous != current),
        builder: (context, state) {
          //   final news = context.watch<NewsBloc>().news;
          if (state.homeStatus == NewsStatus.loading &&
              state.homeNewsList.isEmpty) {
            return const Center(
              child: LoadingListPage()
            );
          } else if (state.homeStatus == NewsStatus.error) {
            // Show a snackbar with the error message
            return AlertError(
              errorMessage: state.homeError,
              onRetry: () {
                context.read<NewsBloc>().add(HomeEvent());
              },
            );
          } else if (state.homeStatus == NewsStatus.success) {
            final homeNews = state.homeNewsList;
            if (homeNews.isEmpty) {
              return const Center(
                child: Text('No news available'),
              );
            }
            return NewsList(
              news: homeNews,
              loadMore: ()  {
                BlocProvider.of<NewsBloc>(context).add(HomeEvent());
              },
            );
          }
          // If the state is NewsInitial or any other state not handled, show an empty container
          return Container();
        });
  }
}
