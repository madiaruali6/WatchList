import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/settings/app_settings_cubit.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../movies/data/datasources/user_movie_local_data_source.dart';
import '../../../movies/domain/usecases/get_searches_count_usecase.dart';
import '../../../movies/domain/usecases/get_viewed_movies_count_usecase.dart';
import '../../../watchlist/presentation/bloc/watchlist_bloc.dart';
import '../../../watchlist/presentation/bloc/watchlist_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Future<int> _viewedCountFuture;
  late Future<int> _searchesCountFuture;
  late Future<UserMovieStats> _userMovieStatsFuture;

  @override
  void initState() {
    super.initState();
    _viewedCountFuture = getIt<GetViewedMoviesCountUseCase>()();
    _searchesCountFuture = getIt<GetSearchesCountUseCase>()();
    _userMovieStatsFuture = getIt<UserMovieLocalDataSource>().getStats();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          final user = authState is AuthAuthenticated ? authState.user : null;
          final email = user?.email ?? l10n.profileUserFallback;
          final joined = user?.joinedAt;
          final joinedText = joined == null
              ? l10n.profileUnknown
              : DateFormat.yMMMd(Localizations.localeOf(context).toString())
                  .format(joined);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(l10n.profileTitle, style: AppTextStyles.heading2),
              const SizedBox(height: 12),
              _ProfileStats(
                email: email,
                joined: joinedText,
                viewedCountFuture: _viewedCountFuture,
                searchesCountFuture: _searchesCountFuture,
                userMovieStatsFuture: _userMovieStatsFuture,
              ),
              const Divider(height: 32),
              Text(l10n.preferencesTitle, style: AppTextStyles.heading2),
              const SizedBox(height: 12),
              const _LanguageTile(),
              const _ThemeTile(),
              const Divider(height: 32),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(l10n.signOut),
                onTap: () {
                  context.read<AuthBloc>().add(const SignOutRequested());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfileStats extends StatelessWidget {
  final String email;
  final String joined;
  final Future<int> viewedCountFuture;
  final Future<int> searchesCountFuture;
  final Future<UserMovieStats> userMovieStatsFuture;

  const _ProfileStats({
    required this.email,
    required this.joined,
    required this.viewedCountFuture,
    required this.searchesCountFuture,
    required this.userMovieStatsFuture,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, watchlistState) {
        final favorites =
            watchlistState is WatchlistLoaded ? watchlistState.items.length : 0;

        return FutureBuilder<List<Object>>(
          future: Future.wait([
            viewedCountFuture,
            searchesCountFuture,
            userMovieStatsFuture,
          ]),
          builder: (context, snapshot) {
            final viewed = snapshot.data?[0] as int? ?? 0;
            final searches = snapshot.data?[1] as int? ?? 0;
            final userStats = snapshot.data?[2] as UserMovieStats?;
            final watched = userStats?.watched ?? viewed;
            final averageRating = userStats?.averageRating ?? 0;
            return Column(
              children: [
                _ProfileRow(
                  icon: Icons.email_outlined,
                  label: l10n.profileEmail,
                  value: email,
                ),
                _ProfileRow(
                  icon: Icons.calendar_today_outlined,
                  label: l10n.profileJoined,
                  value: joined,
                ),
                _ProfileRow(
                  icon: Icons.favorite_border,
                  label: l10n.profileFavorites,
                  value: favorites.toString(),
                ),
                _ProfileRow(
                  icon: Icons.visibility_outlined,
                  label: l10n.profileViewed,
                  value: viewed.toString(),
                ),
                _ProfileRow(
                  icon: Icons.check_circle_outline,
                  label: l10n.profileWatched,
                  value: watched.toString(),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    l10n.statisticsTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _StatCard(
                      icon: Icons.check_circle_outline,
                      label: l10n.statsMoviesWatched,
                      value: watched.toString(),
                    ),
                    _StatCard(
                      icon: Icons.favorite_border,
                      label: l10n.statsFavorites,
                      value: favorites.toString(),
                    ),
                    _StatCard(
                      icon: Icons.search,
                      label: l10n.statsSearches,
                      value: searches.toString(),
                    ),
                    _StatCard(
                      icon: Icons.star_border,
                      label: l10n.statsAverageRating,
                      value: averageRating == 0
                          ? '0.0'
                          : averageRating.toStringAsFixed(1),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colorScheme.primary),
            const SizedBox(height: 6),
            Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, settings) {
        return ListTile(
          leading: const Icon(Icons.language),
          title: Text(l10n.languageTitle),
          trailing: DropdownButton<String>(
            value: settings.locale.languageCode,
            items: [
              DropdownMenuItem(value: 'ru', child: Text(l10n.languageRussian)),
              DropdownMenuItem(value: 'kk', child: Text(l10n.languageKazakh)),
              DropdownMenuItem(value: 'en', child: Text(l10n.languageEnglish)),
            ],
            onChanged: (languageCode) {
              if (languageCode == null) return;
              context.read<AppSettingsCubit>().setLocale(Locale(languageCode));
            },
          ),
        );
      },
    );
  }
}

class _ThemeTile extends StatelessWidget {
  const _ThemeTile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, settings) {
        return SwitchListTile(
          secondary: Icon(
            settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          ),
          title: Text(l10n.darkThemeTitle),
          value: settings.isDarkMode,
          onChanged: (value) {
            context.read<AppSettingsCubit>().setDarkMode(value);
          },
        );
      },
    );
  }
}
