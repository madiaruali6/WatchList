import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/watchlist_item_model.dart';

/// Единственное место, которое знает про структуру коллекций в Firestore.
/// Структура: users/{userId}/watchlist/{movieId}
class WatchlistRemoteDataSource {
  final FirebaseFirestore firestore;

  WatchlistRemoteDataSource(this.firestore);

  CollectionReference<Map<String, dynamic>> _watchlistRef(String userId) {
    return firestore.collection('users').doc(userId).collection('watchlist');
  }

  Stream<List<WatchlistItemModel>> watchlistStream(String userId) {
    return _watchlistRef(userId).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => WatchlistItemModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<void> addToWatchlist(String userId, WatchlistItemModel item) async {
    await _watchlistRef(userId).doc(item.movieId.toString()).set(item.toMap());
  }

  Future<void> removeFromWatchlist(String userId, int movieId) async {
    await _watchlistRef(userId).doc(movieId.toString()).delete();
  }

  Future<bool> isInWatchlist(String userId, int movieId) async {
    final doc = await _watchlistRef(userId).doc(movieId.toString()).get();
    return doc.exists;
  }
}
