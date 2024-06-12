import 'package:ditonton/watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchListStatus {
  final WatchlistRepository watchlistRepository;

  GetWatchListStatus(this.watchlistRepository);

  Future<bool> execute(int id) async {
    return watchlistRepository.isAddedToWatchlist(id);
  }
}
