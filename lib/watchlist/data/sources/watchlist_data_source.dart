import 'package:ditonton/core/errors/exception.dart';
import 'package:ditonton/core/utils/constants.dart';
import 'package:ditonton/watchlist/data/models/watchlist_table.dart';
import 'package:ditonton/watchlist/data/sources/database_helper.dart';

class WatchlistDataSourceImpl implements WatchlistDataSource {
  WatchlistDataSourceImpl({required this.databaseHelper});

  final DatabaseHelper databaseHelper;

  @override
  Future<WatchlistTable?> getWatchlistById(int id) async {
    final result = await databaseHelper.getWatchlistById(id);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlist() async {
    try {
      final result = await databaseHelper.getWatchlist();
      return result.map((item) => WatchlistTable.fromMap(item)).toList();
    } on Exception catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertWatchlist(WatchlistTable watchlistTable) async {
    try {
      final result = await databaseHelper.insertWatchlist(watchlistTable);
      if (result != 0) {
        return WATCHLIST_ADD_MESSAGE;
      } else {
        throw DatabaseException('Failed');
      }
    } on Exception catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(int id) async{
    try {
      final result = await databaseHelper.removeWatchlist(id);
      if (result != 0){
        return WATCHLIST_REMOVE_MESSAGE;
      } else {
        throw DatabaseException('Failed');
      }
    } on Exception catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}

abstract class WatchlistDataSource {
  Future<String> insertWatchlist(WatchlistTable watchlist);

  Future<String> removeWatchlist(int id);

  Future<WatchlistTable?> getWatchlistById(int id);

  Future<List<WatchlistTable>> getWatchlist();
}
