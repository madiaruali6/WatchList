import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/api_config.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../watchlist/domain/entities/watchlist_item.dart';
import '../../../watchlist/presentation/bloc/watchlist_bloc.dart';
import '../../../watchlist/presentation/bloc/watchlist_event.dart';
import '../../../watchlist/presentation/bloc/watchlist_state.dart';
import '../../domain/entities/movie.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;

  const MovieListItem({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    final posterUrl = ApiConfig.posterUrl(movie.posterPath);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: posterUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: posterUrl,
                width: 50,
                height: 75,
                fit: BoxFit.cover,
                placeholder: (_, __) => _posterPlaceholder(),
                errorWidget: (_, __, ___) => _placeholderIcon(),
              )
            : _placeholderIcon(),
      ),
      title: Text(movie.title, style: AppTextStyles.body),
      subtitle: Row(
        children: [
          const Icon(Icons.star, size: 16, color: AppColors.ratingGold),
          const SizedBox(width: 4),
          Text(
            movie.voteAverage.toStringAsFixed(1),
            style: AppTextStyles.bodySecondary,
          ),
          if (movie.releaseDate != null) ...[
            const SizedBox(width: 12),
            Text(movie.releaseDate!, style: AppTextStyles.caption),
          ],
        ],
      ),
      trailing: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          final isSaved = state is WatchlistLoaded && state.contains(movie.id);
          return IconButton(
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: isSaved ? AppColors.secondary : AppColors.textSecondary,
            ),
            onPressed: () {
              final bloc = context.read<WatchlistBloc>();
              if (isSaved) {
                bloc.add(RemoveMovieFromWatchlist(movie.id));
              } else {
                bloc.add(
                  AddMovieToWatchlist(
                    WatchlistItem(
                      movieId: movie.id,
                      title: movie.title,
                      posterPath: movie.posterPath,
                      voteAverage: movie.voteAverage,
                      addedAt: DateTime.now(),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _placeholderIcon() {
    return Container(
      width: 50,
      height: 75,
      color: AppColors.background,
      child: const Icon(Icons.movie, color: AppColors.textSecondary),
    );
  }

  Widget _posterPlaceholder() {
    return Container(
      width: 50,
      height: 75,
      color: AppColors.background,
    );
  }
}
