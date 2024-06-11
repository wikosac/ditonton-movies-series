import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/watchlist/data/sources/watchlist_data_source.dart';
import 'package:ditonton/watchlist/domain/entities/watchlist.dart';
import 'package:ditonton/watchlist/domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  WatchlistRepositoryImpl({required this.watchlistDataSource});

  final WatchlistDataSource watchlistDataSource;

  @override
  ResultFuture<List<Watchlist>> getWatchlistTvSeries() {
    // TODO: implement getWatchlistTvSeries
    throw UnimplementedError();
  }

  @override
  Future<bool> isAddedToWatchlist(int id) {
    // TODO: implement isAddedToWatchlist
    throw UnimplementedError();
  }

  @override
  ResultFuture<String> removeWatchlist(Watchlist watchlist) {
    // TODO: implement removeWatchlist
    throw UnimplementedError();
  }

  @override
  ResultFuture<String> saveWatchlist(Watchlist watchlist) {
    // TODO: implement saveWatchlist
    throw UnimplementedError();
  }
}
