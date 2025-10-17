import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../domain/repositories/news_repository.dart';
import '../../domain/usecases/get_financial_news_usecase.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../data/datasources/news_remote_data_source.dart';
import '../../features/news/presentation/cubit/news_cubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

// Bağımlılık enjeksiyonu kurulumu
Future<void> init() async {
  // Features
  sl.registerFactory(() => NewsCubit(getFinancialNewsUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetFinancialNewsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton(() => NewsRemoteDataSource());

  // Core
  sl.registerLazySingleton(() => NetworkInfo(client: sl()));

  sl.registerLazySingleton(() => http.Client());
}
