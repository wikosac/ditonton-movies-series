import 'package:core/utils/typedef.dart';

import '../repositories/watchlist_repository.dart';

class RemoveWatchlist {
  final WatchlistRepository watchlistRepository;

  RemoveWatchlist(this.watchlistRepository);

  ResultFuture<String> execute(int id) {
    return watchlistRepository.removeWatchlist(id);
  }
}
