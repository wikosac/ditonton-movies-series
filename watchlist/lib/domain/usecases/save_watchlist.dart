import 'package:core/utils/typedef.dart';

import '../entities/watchlist.dart';
import '../repositories/watchlist_repository.dart';

class SaveWatchlist {
  final WatchlistRepository _watchlistRepository;

  SaveWatchlist(this._watchlistRepository);

  ResultFuture<String> execute(Watchlist watchlist) {
    return _watchlistRepository.saveWatchlist(watchlist);
  }
}
