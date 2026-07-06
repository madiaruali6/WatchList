import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/api_config.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    // Подписываемся на живой список один раз при открытии страницы
    context.read<WatchlistBloc>().add(const WatchlistSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мой список')),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WatchlistError) {
            return Center(child: Text(state.message));
          }
          if (state is WatchlistLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Text(
                  'Список пуст. Добавь фильмы через поиск!',
                  style: AppTextStyles.bodySecondary,
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                final posterUrl = ApiConfig.posterUrl(item.posterPath);
                return ListTile(
                  leading: posterUrl.isNotEmpty
                      ? Image.network(posterUrl, width: 50, fit: BoxFit.cover)
                      : const Icon(Icons.movie),
                  title: Text(item.title),
                  subtitle: Text('⭐ ${item.voteAverage.toStringAsFixed(1)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      context.read<WatchlistBloc>().add(
                            RemoveMovieFromWatchlist(item.movieId),
                          );
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
