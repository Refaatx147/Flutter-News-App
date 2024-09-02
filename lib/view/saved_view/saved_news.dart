import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_appp/core/blocs/api_bloc/saved_news_cubit/cubit/saved_news_cubit.dart';
import 'package:news_appp/view/widgets/alerts.dart';
import 'package:news_appp/view/widgets/loading_widget.dart';
import 'package:news_appp/view/widgets/none_saved.dart';
import 'package:news_appp/view/widgets/saved_widget.dart';

class SavedNews extends StatefulWidget {
  const SavedNews({super.key});

  @override
  State<SavedNews> createState() => _SavedNewsState();
}

class _SavedNewsState extends State<SavedNews> {
  
 

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedNewsCubit, SavedNewsState>(
        builder: (context, state) {
      if (state is SavedNewsLoading) {
        return const Center(
          child: LoadingListPage(),
        );
      } else if (state is SavedNewsFailure) {
        return AlertError(
            errorMessage: "there is an error",
            onRetry: () {
              BlocProvider.of<SavedNewsCubit>(context).getSavedNews();
            });
      } else if (state is SavedNewsSuccess) {
        final news = state.savedNews.reversed.toList();
        if (news.isEmpty) {
          return const Center(
            child: NoSavedNewsMessage()
          );
        } else {
          return SavedNewsList(savedNews: news);
        }
      }
      return const SizedBox.shrink();
    });
  }
}
