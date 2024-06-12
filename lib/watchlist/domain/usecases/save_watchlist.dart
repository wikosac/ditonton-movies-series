import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/watchlist/domain/entities/watchlist.dart';
import 'package:ditonton/watchlist/domain/repositories/watchlist_repository.dart';

class SaveWatchlist {
  final WatchlistRepository _watchlistRepository;

  SaveWatchlist(this._watchlistRepository);

  ResultFuture<String> execute(Watchlist watchlist) {
    return _watchlistRepository.saveWatchlist(watchlist);
  }
}
