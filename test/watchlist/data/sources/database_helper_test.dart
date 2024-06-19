import 'package:ditonton/watchlist/data/models/watchlist_table.dart';
import 'package:ditonton/watchlist/data/sources/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'database_helper_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  late MockDatabase mockDatabase;
  late DatabaseHelper databaseHelper;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    mockDatabase = MockDatabase();
    databaseHelper = DatabaseHelper();
  });

  final watchlistTable =
      WatchlistTable(id: 1, posterPath: 'path', mediaType: 'movie');

  group('Database Helper', () {
    test('should return watchlist id when insertWatchlist is called', () async {
      when(mockDatabase.insert(any, any)).thenAnswer((_) async => 1);

      final result = await databaseHelper.insertWatchlist(watchlistTable);

      expect(result, 1);
    });

    test('should return watchlist id when removeWatchlist is called', () async {
      when(mockDatabase.delete(any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      final result = await databaseHelper.removeWatchlist(1);

      expect(result, 1);
    });

    test('should return watchlist data when getWatchlistById is called',
        () async {
      when(mockDatabase.query(any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => [
                {
                  'id': 1,
                  'posterPath': 'path',
                  'mediaType': 'movie',
                }
              ]);

      final result = await databaseHelper.getWatchlistById(1);

      expect(result, isNull);
    });

    test('should return empty list when getWatchlist is called', () async {
      when(mockDatabase.query(any)).thenAnswer((_) async => []);

      final result = await databaseHelper.getWatchlist();

      expect(result, isEmpty);
    });

    test('should return watchlist list when getWatchlist is called', () async {
      when(mockDatabase.query(any)).thenAnswer((_) async => [
            {
              'id': 1,
              'posterPath': 'path',
              'mediaType': 'movie',
            }
          ]);

      final result = await databaseHelper.getWatchlist();

      expect(result, isEmpty);
    });
  });
}
