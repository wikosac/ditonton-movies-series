import 'package:dartz/dartz.dart';
import 'package:ditonton/core/errors/exception.dart';
import 'package:ditonton/core/errors/failure.dart';
import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/watchlist/data/models/watchlist_table.dart';
import 'package:ditonton/watchlist/data/sources/watchlist_data_source.dart';
import 'package:ditonton/watchlist/domain/entities/watchlist.dart';
import 'package:ditonton/watchlist/domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  WatchlistRepositoryImpl({required this.watchlistDataSource});

  final WatchlistDataSource watchlistDataSource;

  @override
  ResultFuture<List<Watchlist>> getWatchlist() async {
    final result = await watchlistDataSource.getWatchlist();
    return Right(result.map((item) => item.toWatchlist()).toList());
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
    } catch (e) {
      throw e;
    }
  }
}
