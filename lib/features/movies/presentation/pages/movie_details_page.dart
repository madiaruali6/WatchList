import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/api_config.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/datasources/user_movie_local_data_source.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/user_movie_entry.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final _notesController = TextEditingController();
  final _store = getIt<UserMovieLocalDataSource>();

  UserMovieEntry? _entry;
  UserMovieStatus _status = UserMovieStatus.wantToWatch;
  int _rating = 0;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadEntry();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadEntry() async {
    final entry = await _store.getEntry(widget.movie.id);
    if (!mounted) return;
    setState(() {
      _entry = entry;
      _status = entry?.status ?? UserMovieStatus.wantToWatch;
      _rating = entry?.rating ?? 0;
      _notesController.text = entry?.notes ?? '';
      _isLoaded = true;
    });
  }

  Future<void> _saveEntry() async {
    final entry = (_entry ??
            UserMovieEntry(
              movie: widget.movie,
              status: _status,
              updatedAt: DateTime.now(),
            ))
        .copyWith(
      movie: widget.movie,
      status: _status,
      rating: _rating,
      notes: _notesController.text.trim(),
      updatedAt: DateTime.now(),
    );

    await _store.saveEntry(entry);
    if (!mounted) return;
    setState(() => _entry = entry);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final posterUrl = ApiConfig.posterUrl(widget.movie.posterPath);

    return Scaffold(
      appBar: AppBar(title: Text(widget.movie.title)),
      body: !_isLoaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: posterUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: posterUrl,
                              width: 110,
                              height: 165,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 110,
                              height: 165,
                              color: Theme.of(context).colorScheme.surface,
                              child: const Icon(Icons.movie, size: 40),
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${l10n.ratingLabel} ${widget.movie.voteAverage.toStringAsFixed(1)}',
                          ),
                          if (widget.movie.releaseDate != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              l10n.releaseDateLabel(widget.movie.releaseDate!),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(l10n.descriptionTitle,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  widget.movie.overview?.isNotEmpty == true
                      ? widget.movie.overview!
                      : l10n.descriptionEmpty,
                ),
                const SizedBox(height: 24),
                Text(l10n.statusTitle,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                _StatusCheckbox(
                  title: l10n.statusWatched,
                  value: _status == UserMovieStatus.watched,
                  onChanged: () => _setStatus(UserMovieStatus.watched),
                ),
                _StatusCheckbox(
                  title: l10n.statusWatching,
                  value: _status == UserMovieStatus.watching,
                  onChanged: () => _setStatus(UserMovieStatus.watching),
                ),
                _StatusCheckbox(
                  title: l10n.statusPlanToWatch,
                  value: _status == UserMovieStatus.wantToWatch,
                  onChanged: () => _setStatus(UserMovieStatus.wantToWatch),
                ),
                _StatusCheckbox(
                  title: l10n.statusDropped,
                  value: _status == UserMovieStatus.dropped,
                  onChanged: () => _setStatus(UserMovieStatus.dropped),
                ),
                const SizedBox(height: 24),
                Text(l10n.myRatingTitle,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (index) {
                    final value = index + 1;
                    return IconButton(
                      tooltip: '$value',
                      icon: Icon(
                        value <= _rating ? Icons.star : Icons.star_border,
                        color: AppColors.ratingGold,
                      ),
                      onPressed: () {
                        setState(() => _rating = value);
                        _saveEntry();
                      },
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Text(l10n.notesTitle,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                TextField(
                  controller: _notesController,
                  minLines: 3,
                  maxLines: 6,
                  decoration: InputDecoration(hintText: l10n.notesHint),
                  onChanged: (_) => _saveEntry(),
                ),
              ],
            ),
    );
  }

  void _setStatus(UserMovieStatus status) {
    setState(() => _status = status);
    _saveEntry();
  }
}

class _StatusCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final VoidCallback onChanged;

  const _StatusCheckbox({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      onChanged: (_) => onChanged(),
    );
  }
}
