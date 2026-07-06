import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/app_database.dart';
import '../network/dio_client.dart';
import '../settings/app_settings_cubit.dart';
import '../../features/movies/data/datasources/movie_local_data_source.dart';
import '../../features/movies/data/datasources/movie_remote_data_source.dart';
import '../../features/movies/data/datasources/user_movie_local_data_source.dart';
import '../../features/movies/data/repositories/movie_repository_impl.dart';
import '../../features/movies/domain/repositories/movie_repository.dart';
import '../../features/movies/domain/usecases/get_search_overview_usecase.dart';
import '../../features/movies/domain/usecases/get_searches_count_usecase.dart';
import '../../features/movies/domain/usecases/get_viewed_movies_count_usecase.dart';
import '../../features/movies/domain/usecases/mark_movie_viewed_usecase.dart';
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

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => DioClient.create());
  getIt.registerLazySingleton(() => AppDatabase());
  getIt.registerLazySingleton(() => AppSettingsCubit(getIt()));

  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => AuthRemoteDataSource(getIt()));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => SignInUseCase(getIt()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt()));

  getIt.registerLazySingleton(
    () => AuthBloc(
      signUpUseCase: getIt(),
      signInUseCase: getIt(),
      signOutUseCase: getIt(),
      authRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => MovieLocalDataSource(getIt()));
  getIt.registerLazySingleton(() => UserMovieLocalDataSource(getIt()));

  getIt.registerLazySingleton(() => MovieRemoteDataSource(getIt()));

  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton(() => SearchMoviesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetSearchOverviewUseCase(getIt()));
  getIt.registerLazySingleton(() => GetSearchesCountUseCase(getIt()));
  getIt.registerLazySingleton(() => GetViewedMoviesCountUseCase(getIt()));
  getIt.registerLazySingleton(() => MarkMovieViewedUseCase(getIt()));

  getIt.registerFactory(() => MovieSearchBloc(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => WatchlistRemoteDataSource(getIt()));
  getIt.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetWatchlistStreamUseCase(getIt()));
  getIt.registerLazySingleton(() => AddToWatchlistUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveFromWatchlistUseCase(getIt()));

  getIt.registerFactoryParam<WatchlistBloc, String, void>(
    (userId, _) => WatchlistBloc(
      getWatchlistStreamUseCase: getIt(),
      addToWatchlistUseCase: getIt(),
      removeFromWatchlistUseCase: getIt(),
      userId: userId,
    ),
  );
}
