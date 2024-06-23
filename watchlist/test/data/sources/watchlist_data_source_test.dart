import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/data/sources/watchlist_data_source.dart';

import '../../dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistDataSource dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = WatchlistDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  final tWatchlist = dummyWatchlistTable;
  final tWatchlistMap = dummyWatchlistMap;
  final tAddMessage = WATCHLIST_ADD_MESSAGE;
  final tRemoveMessage = WATCHLIST_REMOVE_MESSAGE;
  final tError = DatabaseException('Internal error');

  group('save watchlist movies', () {
    test('should return success message when insert to database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.insertWatchlist(tWatchlist))
              .thenAnswer((_) async => 1);
          // act
          final actual = await dataSource.insertWatchlist(tWatchlist);
          // assert
          expect(actual, tAddMessage);
        });

    test('should throw DatabaseException when insert to database is failed',
            () {
          // arrange
          when(mockDatabaseHelper.insertWatchlist(tWatchlist))
              .thenThrow(tError);
          // act
          final actual = () async => await dataSource.insertWatchlist(tWatchlist);
          // assert
          expect(actual, throwsA(isA<DatabaseException>()));
        });
  });

  group('remove watchlist movies', () {
    test('should return success message when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeWatchlist(tWatchlist.id))
              .thenAnswer((_) async => 1);
          // act
          final actual = await dataSource.removeWatchlist(tWatchlist.id);
          // assert
          expect(actual, tRemoveMessage);
        });

    test('should throw DatabaseException when remove from database is failed',
            () {
          // arrange
          when(mockDatabaseHelper.removeWatchlist(tWatchlist.id))
              .thenThrow(tError);
          // act
          final actual = () async => await dataSource.removeWatchlist(tWatchlist.id);
          // assert
          expect(actual, throwsA(isA<DatabaseException>()));
        });
  });

  group('Get Movie Detail By Id', () {
    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistById(1))
          .thenAnswer((_) async => tWatchlistMap);
      // act
      final actual = await dataSource.getWatchlistById(1);
      // assert
      expect(actual, tWatchlist);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistById(1)).thenAnswer((_) async => null);
      // act
      final actual = await dataSource.getWatchlistById(1);
      // assert
      expect(actual, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlist())
          .thenAnswer((_) async => [tWatchlistMap]);
      // act
      final actual = await dataSource.getWatchlist();
      // assert
      expect(actual, [tWatchlist]);
    });
  });
}