import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_appp/core/app_constants/app_strings.dart';
import 'package:news_appp/core/blocs/bloc_observer.dart';
import 'package:news_appp/core/blocs/layout_cubit/home_layout_cubit.dart';
import 'package:news_appp/core/database/cache/cache_helper.dart';
import 'package:news_appp/dependency_injection.dart' as di;
import 'core/app_routers/app_router.dart';

void main() async {
  WidgetsFlutterBinding();
  await CacheHelper().init();
  Bloc.observer = MyBlocObserver();
  await di.init();
 //CacheHelper().clearData();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return  MaterialApp(
              darkTheme: ThemeData.dark(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(
                useMaterial3: true,
              ),
              themeMode: context.read<HomeCubit>().darkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              onGenerateRoute: AppRouter().onGenerateRoute,
              initialRoute: AppStrings.homeLayout,
            
          );
        },
      ),
    );
  }
}
