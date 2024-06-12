import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/watchlist/domain/repositories/watchlist_repository.dart';

class RemoveWatchlist {
  final WatchlistRepository watchlistRepository;

  RemoveWatchlist(this.watchlistRepository);

  ResultFuture<String> execute(int id) {
    return watchlistRepository.removeWatchlist(id);
  }
}
