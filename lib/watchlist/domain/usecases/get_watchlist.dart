import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/watchlist/domain/entities/watchlist.dart';
import 'package:ditonton/watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlist {
  final WatchlistRepository watchlistRepository;

  GetWatchlist(this.watchlistRepository);

  ResultFuture<List<Watchlist>> execute() {
    return watchlistRepository.getWatchlist();
  }
}
