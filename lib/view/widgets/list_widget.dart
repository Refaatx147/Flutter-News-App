import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_appp/core/app_constants/app_strings.dart';
import 'package:news_appp/core/blocs/api_bloc/saved_news_cubit/cubit/saved_news_cubit.dart';
import 'package:news_appp/core/blocs/layout_cubit/home_layout_cubit.dart';
import 'package:news_appp/core/model/home_news_model/home_news_model.dart';
import 'package:news_appp/view/widgets/alerts.dart';

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
    }
  }

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedNewsCubit, SavedNewsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ListView.builder(
            controller: _controller,
            itemCount: widget.news.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: context.read<HomeCubit>().darkMode
                      ? Colors.blueGrey[800]
                      : Colors.grey[200],
                  shadowColor: context.read<HomeCubit>().darkMode
                      ? Colors.black54
                      : Colors.grey.withOpacity(0.2),
                  child: Stack(children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15.0),
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
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          widget.news[index].title!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: context.read<HomeCubit>().darkMode
                                    ? Colors.white
                                    : Colors.tealAccent[100],
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: context.read<HomeCubit>().darkMode
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(13)),
                            child: IconButton(
                              padding: const EdgeInsets.all(3),
                              onPressed: () {
                                BlocProvider.of<SavedNewsCubit>(context)
                                    .saveNew(widget.news[index]);
                                showStatusAlert(
                                  context,
                                  isSaved: true,
                                  isRepeated:
                                      context.read<SavedNewsCubit>().repeated,
                                );
                              },
                              icon: Icon(
                                Icons.save,
                                size: 27,
                                color: context.read<HomeCubit>().darkMode
                                    ? Colors.amber[600]!.withOpacity(0.9)
                                    : const Color.fromARGB(255, 15, 52, 72)
                                        .withOpacity(.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]));
            },
          ),
        );
      },
    );
  }
}
