// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_appp/core/app_constants/category_list.dart';
import 'package:news_appp/core/blocs/api_bloc/category_news_bloc/bloc/category_news_bloc.dart';
import 'package:news_appp/core/blocs/layout_cubit/home_layout_cubit.dart';
import 'package:news_appp/view/widgets/alert_error.dart';
import 'package:news_appp/view/widgets/list_widget.dart';
import 'package:news_appp/view/widgets/loading_widget.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller =
        TabController(length: CategoryList.categoryItems.length, vsync: this);
    super.initState();
    // BlocProvider.of<CategoryNewsBloc>(context)
    //     .add(CategoryEvent(category: CategoryList.categoryItems[0]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.read<HomeCubit>().darkMode
                        ? Colors.amber[50]
                        : Colors.blueGrey[900],
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.elliptical(20, 20),
                      right: Radius.elliptical(20, 20),
                    ),
                  ),
                  child: BlocBuilder<CategoryNewsBloc, CategoryNewsStates>(
                    builder: (context, state) {
                      return TabBar(
                        onTap: (int index) {
                          // if (index == 0) {
                          // }
                          BlocProvider.of<CategoryNewsBloc>(context).add(
                            CategoryEvent(
                                category: CategoryList.categoryItems[index]),
                          );

                          BlocProvider.of<CategoryNewsBloc>(context)
                              .state
                              .categoryNewsList
                              .clear();
                          BlocProvider.of<CategoryNewsBloc>(context).catPage =
                              1;
                        },
                        controller: controller,
                        tabs: CategoryList.categoryItems
                            .map((tabName) => Tab(
                                  text: tabName,
                                ))
                            .toList(),

                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          gradient: LinearGradient(
                            colors: context.read<HomeCubit>().darkMode
                                ? [Colors.orange, Colors.yellow]
                                : [Colors.teal, Colors.lightGreen],
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),

                        unselectedLabelStyle: TextStyle(
                            fontSize: 19.0,
                            color: context.read<HomeCubit>().darkMode
                                ? Colors.blueGrey[800]
                                : Colors.white,
                            fontWeight: FontWeight.bold),
                        labelStyle: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: context.read<HomeCubit>().darkMode
                              ? Colors.blueGrey[900]
                              : Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        tabAlignment: TabAlignment.start,
                        // labelColor: Colors.white,
                        labelPadding: const EdgeInsets.only(
                            top: 7, bottom: 8, right: 17, left: 17),
                        overlayColor: WidgetStateColor.resolveWith(
                          (states) => Colors.purpleAccent.withOpacity(0.3),
                        ), // Ripple effect color
                        splashBorderRadius: BorderRadius.circular(500),
                        indicatorPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 13),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: CategoryList.categoryItems.map((categoryItem) {
                    return BlocBuilder<CategoryNewsBloc, CategoryNewsStates>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (context, state) {
                          if (state.categoryStatus ==
                                  CategoryNewsStatus.loading &&
                              state.categoryNewsList.isEmpty) {
                            return const Center(
                              child: LoadingListPage(),
                            );
                          } else if (state.categoryStatus ==
                              CategoryNewsStatus.error) {
                            return AlertError(
                              errorMessage: state.categoryError,
                              onRetry: () {
                                context.read<CategoryNewsBloc>().add(
                                    CategoryEvent(
                                        category:
                                            CategoryList.categoryItems[0]));
                              },
                            );
                          } else if (state.categoryStatus ==
                              CategoryNewsStatus.success) {
                            final categoryNews = state.categoryNewsList;
                            if (categoryNews.isEmpty) {
                              return const Center(
                                child: LoadingListPage(),
                              );
                            }
                            return NewsList(
                              news: categoryNews,
                              loadMore: () {
                                //    await Future.delayed(const Duration(seconds: 2));

                                // ignore: use_build_context_synchronously
                                BlocProvider.of<CategoryNewsBloc>(context)
                                    .add(CategoryEvent(category: categoryItem));
                              },
                            );
                          }

                          return Container();
                        });
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
