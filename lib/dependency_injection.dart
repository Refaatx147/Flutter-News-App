import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_appp/core/api/api_consumer.dart';
import 'package:news_appp/core/api/dio_consumer.dart';
import 'package:news_appp/core/blocs/api_bloc/category_news_bloc/bloc/category_news_bloc.dart';
import 'package:news_appp/core/blocs/api_bloc/home_news_bloc/home_news_bloc.dart';
import 'package:news_appp/core/database/data_source/local_data_source.dart';
import 'package:news_appp/core/database/data_source/remote_data_source.dart';
import 'package:news_appp/core/repositories/news_repository/news_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton(() => NewsRepository(sl(), sl()));
  sl.registerFactory(() => NewsBloc(sl()));
  sl.registerFactory(() => CategoryNewsBloc(sl()));
  sl.registerFactory(() => RemoteDataSource(sl()));
  sl.registerFactory(() => LocalDataSource());

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(sl()));

  // Register NewsBloc using NewsRepository
}
