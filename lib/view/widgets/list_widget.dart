import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_appp/core/app_constants/app_strings.dart';
import 'package:news_appp/core/blocs/layout_cubit/home_layout_cubit.dart';

import 'package:news_appp/core/model/home_news_model/home_news_model.dart';

class NewsList extends StatefulWidget {
  final List<HomeNewsModel> news;
  final Function() loadMore;
  const NewsList({
    Key? key,
    required this.news,
    required this.loadMore,
  }) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  int currentPage = 1;
  final ScrollController _controller = ScrollController();

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      widget.loadMore();
      //  currentPage++;
    }
  }

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: widget.news.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: context.read<HomeCubit>().darkMode
              ? Colors.amber[50]
              : Colors.white,
          shadowColor: context.read<HomeCubit>().darkMode
              ? Colors.black54
              : Colors.grey.withOpacity(0.2),
          child: Container(
            margin: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: widget.news[index].urlToImage != null
                      ? NetworkImage(widget.news[index].urlToImage!)
                      : const NetworkImage(AppStrings.defaultImage),
                  fit: BoxFit.cover,
                )),
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
              child: Text(
                widget.news[index].title!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: context.read<HomeCubit>().darkMode
                          ? Colors.white
                          : Colors.tealAccent[100],
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
