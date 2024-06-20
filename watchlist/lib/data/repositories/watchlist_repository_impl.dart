import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/watchlist.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../models/watchlist_table.dart';
import '../sources/watchlist_data_source.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  WatchlistRepositoryImpl({required this.watchlistDataSource});

  final WatchlistDataSource watchlistDataSource;

  @override
  ResultFuture<List<Watchlist>> getWatchlist() async {
    try {
      final result = await watchlistDataSource.getWatchlist();
      return Right(result.map((item) => item.toWatchlist()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await watchlistDataSource.getWatchlistById(id);
    return result != null;
  }

  @override
  ResultFuture<String> removeWatchlist(int id) async {
    try {
      final result = await watchlistDataSource.removeWatchlist(id);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  ResultFuture<String> saveWatchlist(Watchlist watchlist) async {
    try {
      final result = await watchlistDataSource
          .insertWatchlist(WatchlistTable.fromWatchlist(watchlist));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
