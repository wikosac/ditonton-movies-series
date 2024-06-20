
import 'package:core/utils/typedef.dart';

import '../entities/watchlist.dart';

abstract class WatchlistRepository {
  ResultFuture<String> saveWatchlist(Watchlist watchlist);

  ResultFuture<String> removeWatchlist(int id);

  Future<bool> isAddedToWatchlist(int id);

  ResultFuture<List<Watchlist>> getWatchlist();
}