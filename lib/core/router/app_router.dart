import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/movies/presentation/bloc/movie_search_bloc.dart';
import '../../features/movies/domain/entities/movie.dart';
import '../../features/movies/presentation/pages/movie_details_page.dart';
import '../../features/movies/presentation/pages/movie_search_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/watchlist/presentation/bloc/watchlist_bloc.dart';
import '../../features/watchlist/presentation/bloc/watchlist_event.dart';
import '../../features/watchlist/presentation/pages/watchlist_page.dart';
import '../../l10n/generated/app_localizations.dart';
import '../di/injection.dart';
import 'app_routes.dart';

GoRouter createAppRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final isAuthRoute = state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register;

      if (authState is AuthLoading || authState is AuthInitial) {
        return null;
      }

      if (authState is AuthAuthenticated) {
        return isAuthRoute ? AppRoutes.search : null;
      }

      return isAuthRoute ? null : AppRoutes.login;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginPage(
          registeredEmail: state.uri.queryParameters['registered'],
        ),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          final authState = context.read<AuthBloc>().state;
          if (authState is! AuthAuthenticated) {
            return const _AuthLoadingPage();
          }

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<WatchlistBloc>(param1: authState.user.id)
                  ..add(const WatchlistSubscriptionRequested()),
              ),
              BlocProvider(create: (_) => getIt<MovieSearchBloc>()),
            ],
            child: MainScaffold(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.search,
                builder: (context, state) => const MovieSearchPage(),
              ),
              GoRoute(
                path: AppRoutes.movieDetails,
                builder: (context, state) {
                  final movie = state.extra as Movie?;
                  if (movie == null) {
                    return const MovieSearchPage();
                  }
                  return MovieDetailsPage(movie: movie);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.watchlist,
                builder: (context, state) => const WatchlistPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.search), label: l10n.searchNav),
          NavigationDestination(
            icon: const Icon(Icons.bookmark),
            label: l10n.watchlistNav,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: l10n.settingsNav,
          ),
        ],
      ),
    );
  }
}

class _AuthLoadingPage extends StatelessWidget {
  const _AuthLoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
