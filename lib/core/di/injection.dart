import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';
import '../../features/movies/data/datasources/movie_remote_data_source.dart';
import '../../features/movies/data/repositories/movie_repository_impl.dart';
import '../../features/movies/domain/repositories/movie_repository.dart';
import '../../features/movies/domain/usecases/search_movies_usecase.dart';
import '../../features/movies/presentation/bloc/movie_search_bloc.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/watchlist/data/datasources/watchlist_remote_data_source.dart';
import '../../features/watchlist/data/repositories/watchlist_repository_impl.dart';
import '../../features/watchlist/domain/repositories/watchlist_repository.dart';
import '../../features/watchlist/domain/usecases/add_to_watchlist_usecase.dart';
import '../../features/watchlist/domain/usecases/get_watchlist_stream_usecase.dart';
import '../../features/watchlist/domain/usecases/remove_from_watchlist_usecase.dart';
import '../../features/watchlist/presentation/bloc/watchlist_bloc.dart';

/// Единая точка регистрации всех зависимостей приложения.
/// Вызывается один раз в main() до runApp().
///
/// getIt<ЧтоТоНужное>() — так достаём объект где угодно в коде.
final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // --- Core ---
  getIt.registerLazySingleton(() => DioClient.create());

  // --- Feature: Auth ---
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => AuthRemoteDataSource(getIt()));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => SignInUseCase(getIt()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt()));

  // AuthBloc регистрируем как singleton (не factory!) — он один на
  // всё приложение и живёт всё время, слушая authStateChanges
  getIt.registerLazySingleton(
    () => AuthBloc(
      signUpUseCase: getIt(),
      signInUseCase: getIt(),
      signOutUseCase: getIt(),
      authRepository: getIt(),
    ),
  );

  // --- Feature: Movies ---
  // Data source: создаётся один раз на всё приложение (singleton)
  getIt.registerLazySingleton(() => MovieRemoteDataSource(getIt()));

  // Repository: регистрируем через абстракцию (MovieRepository),
  // но создаём конкретную реализацию (MovieRepositoryImpl).
  // Это и есть суть Dependency Injection — presentation слой попросит
  // MovieRepository и не будет знать, что за реализация под капотом.
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(getIt()),
  );

  // Use case
  getIt.registerLazySingleton(() => SearchMoviesUseCase(getIt()));

  // BLoC: НЕ singleton — каждый раз, когда он нужен, создаём новый
  // экземпляр (factory), чтобы старое состояние не "утекало" между экранами
  getIt.registerFactory(() => MovieSearchBloc(getIt()));

  // --- Feature: Watchlist ---
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => WatchlistRemoteDataSource(getIt()));
  getIt.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetWatchlistStreamUseCase(getIt()));
  getIt.registerLazySingleton(() => AddToWatchlistUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveFromWatchlistUseCase(getIt()));

  // WatchlistBloc нужен userId текущего юзера — поэтому регистрируем
  // через registerFactoryParam: передаём userId в момент создания,
  // а не заранее (ведь на момент setupDependencyInjection юзер
  // ещё может быть не залогинен).
  getIt.registerFactoryParam<WatchlistBloc, String, void>(
    (userId, _) => WatchlistBloc(
      getWatchlistStreamUseCase: getIt(),
      addToWatchlistUseCase: getIt(),
      removeFromWatchlistUseCase: getIt(),
      userId: userId,
    ),
  );
}
