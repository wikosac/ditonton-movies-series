import 'package:ditonton/watchlist/data/models/watchlist_table.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy/dummy_objects.dart';

void main() {
  final tWatchlistModel = dummyWatchlistTable;
  final tWatchlistEntity = dummyWatchlist;
  final tWatchlistMap = dummyWatchlistMap;

  test('return model from map', () {
    final actual = WatchlistTable.fromMap(dummyWatchlistMap);
    expect(actual, tWatchlistModel);
  });

  test('return model from entity', () {
    final actual = WatchlistTable.fromWatchlist(tWatchlistEntity);
    expect(actual, tWatchlistModel);
  });

  test('return map from model', () {
    final actual = tWatchlistModel.toJson();
    expect(actual, tWatchlistMap);
  });

  test('return entity from model', () {
    final actual = tWatchlistModel.toWatchlist();
    expect(actual, tWatchlistEntity);
  });
}
