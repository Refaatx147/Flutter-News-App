import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_appp/core/app_constants/app_strings.dart';
import 'package:news_appp/core/database/cache/cache_helper.dart';

part 'home_layout_state.dart';

class HomeCubit extends Cubit<HomeState> {
  bool darkMode = CacheHelper().getData(key: AppStrings.appTheme) ?? false;
  HomeCubit() : super(HomeInitial());

  void changeMode() {
    emit(HomeChangeMode());
    darkMode = !darkMode;
    CacheHelper().saveData(key: AppStrings.appTheme, value: darkMode);
  }

  int currentIndex=0;

  void changePage({required int index})
  {
    currentIndex = index;
    emit(LayoutChangePage());

  }

}
