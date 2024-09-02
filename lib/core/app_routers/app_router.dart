import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_appp/core/app_constants/app_strings.dart';
import 'package:news_appp/core/blocs/api_bloc/home_news_bloc/home_news_bloc.dart';
import 'package:news_appp/dependency_injection.dart';
import 'package:news_appp/view/home_layout/home_layout.dart';
import 'package:news_appp/view/home_view/home_view.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppStrings.homeLayout:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            //    lazy: true,
            create: (BuildContext context) => sl<NewsBloc>()..add(HomeEvent()),
            child: HomeLayout(),
          ),
        );
      case AppStrings.homeView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            //    lazy: true,
            create: (BuildContext context) => sl<NewsBloc>()..add(HomeEvent()),
            child: const HomeView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text("${AppStrings.defaultRoute} ${settings.name}),"),
            ),
          ),
        );
    }
  }
}
