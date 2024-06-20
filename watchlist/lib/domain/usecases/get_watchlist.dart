import 'package:core/utils/typedef.dart';

import '../entities/watchlist.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlist {
  final WatchlistRepository watchlistRepository;

  GetWatchlist(this.watchlistRepository);

  ResultFuture<List<Watchlist>> execute() {
    return watchlistRepository.getWatchlist();
  }
}
