import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_appp/core/app_constants/app_strings.dart';
import 'package:news_appp/core/app_constants/category_list.dart';
import 'package:news_appp/core/blocs/api_bloc/category_news_bloc/bloc/category_news_bloc.dart';
import 'package:news_appp/core/blocs/api_bloc/saved_news_cubit/cubit/saved_news_cubit.dart';
import 'package:news_appp/core/blocs/layout_cubit/home_layout_cubit.dart';
import 'package:news_appp/dependency_injection.dart';
import 'package:news_appp/view/category_view/category_view.dart';
import 'package:news_appp/view/home_view/home_view.dart';
import 'package:news_appp/view/saved_view/saved_news.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});

  final pageController = PageController();

  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CategoryNewsBloc>()
            ..add(CategoryEvent(category: CategoryList.categoryItems[0])),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => sl<SavedNewsCubit>()..getSavedNews(),
        ),
      ],
      child: Scaffold(
        backgroundColor: context.read<HomeCubit>().darkMode
            ? Colors.blueGrey[900]
            : Colors.white,
        appBar: AppBar(
          //    centerTitle: true,
          backgroundColor: context.read<HomeCubit>().darkMode
              ? Colors.blueGrey[900]
              : Colors.white,
          title: Text(
            'News App',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: context.read<HomeCubit>().darkMode
                  ? Colors.white
                  : Colors.blue[900],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<HomeCubit>().changeMode();
                },
                icon: context.read<HomeCubit>().darkMode
                    ? const Icon(
                        Icons.dark_mode_outlined,
                        size: 28,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.light_mode_rounded,
                        size: 28,
                        color: Colors.blue[900],
                      )),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: PageView(
          controller: pageController,
          children: const [
            HomeView(),
            CategoryView(),
            SavedNews(),
          ],
          onPageChanged: (int index) {
            context.read<HomeCubit>().changePage(index: index);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.read<HomeCubit>().darkMode
              ? Colors.blueGrey[600]
              : Colors.white,
          selectedItemColor: context.read<HomeCubit>().darkMode
              ? const Color.fromARGB(255, 243, 255, 116)
              : Colors.blue[900],
          unselectedItemColor: context.read<HomeCubit>().darkMode
              ? Colors.lime[800]!.withOpacity(0.7)
              : Colors.blueGrey[300],
          type: BottomNavigationBarType.fixed,
          currentIndex: context.read<HomeCubit>().currentIndex,
          // key: GlobalKey(),
          items: const [
            BottomNavigationBarItem(
                label: AppStrings.homeString,
                icon: Icon(Icons.home_rounded),
                activeIcon: Icon(Icons.home_rounded),
                tooltip: AppStrings.homeString),
            BottomNavigationBarItem(
                label: AppStrings.categoryString,
                icon: Icon(Icons.category_rounded),
                activeIcon: Icon(Icons.category_rounded),
                tooltip: AppStrings.categoryString),
            BottomNavigationBarItem(
                label: AppStrings.savedNews,
                icon: Icon(Icons.save),
                activeIcon: Icon(Icons.save),
                tooltip: AppStrings.savedNews),
          ],
          onTap: (int index) {
            context.read<HomeCubit>().changePage(index: index);
            pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
