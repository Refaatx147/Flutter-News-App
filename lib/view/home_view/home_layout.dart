import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_appp/core/app_constants/app_strings.dart';
import 'package:news_appp/core/app_constants/category_list.dart';
import 'package:news_appp/core/blocs/api_bloc/category_news_bloc/bloc/category_news_bloc.dart';
import 'package:news_appp/core/blocs/layout_cubit/home_layout_cubit.dart';
import 'package:news_appp/dependency_injection.dart';
import 'package:news_appp/view/home_view/category_view.dart';
import 'package:news_appp/view/home_view/home_view.dart';

class HomeLayout extends StatelessWidget {
  final pageController = PageController();
  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.read<HomeCubit>().darkMode
          ? const Color.fromARGB(255, 14, 3, 3)
          : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:
            context.read<HomeCubit>().darkMode ? Colors.black : Colors.white,
        title: Text(
          'News App',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: context.read<HomeCubit>().darkMode
                ? Colors.white
                : Colors.blueGrey[900],
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
                      size: 30,
                    )
                  : Icon(
                      Icons.light_mode_rounded,
                      size: 30,
                      color: Colors.deepOrangeAccent[200],
                    )),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          const HomeView(),
          BlocProvider(
            create: (context) => sl<CategoryNewsBloc>()
              ..add(CategoryEvent(category: CategoryList.categoryItems[0])),
            child: const CategoryView(),
          ),
        ],
        onPageChanged: (int index) {
          context.read<HomeCubit>().changePage(index: index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.read<HomeCubit>().darkMode
            ? const Color.fromARGB(255, 251, 247, 235)
            : Colors.white,
        selectedItemColor: context.read<HomeCubit>().darkMode
            ? const Color.fromARGB(255, 172, 48, 21)
            : Colors.blue[900],
        unselectedItemColor: context.read<HomeCubit>().darkMode
            ? const Color.fromARGB(255, 232, 157, 131)
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
        ],
        onTap: (int index) {
          context.read<HomeCubit>().changePage(index: index);
          pageController.jumpToPage(index);
        },
      ),
    );
  }
}
