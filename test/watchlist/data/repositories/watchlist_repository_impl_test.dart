import 'package:dartz/dartz.dart';
import 'package:ditonton/core/errors/exception.dart';
import 'package:ditonton/core/errors/failure.dart';
import 'package:ditonton/core/utils/constants.dart';
import 'package:ditonton/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:ditonton/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../dummy/dummy_objects.dart';

void main() {
  late WatchlistRepository repository;
  late MockWatchlistDataSource mockWatchlistDataSource;

  setUp(() {
    mockWatchlistDataSource = MockWatchlistDataSource();
    repository =
        WatchlistRepositoryImpl(watchlistDataSource: mockWatchlistDataSource);
  });

  final tWatchlistModel = dummyWatchlistTable;
  final tWatchlistEntity = dummyWatchlist;
  final tAddMessage = WATCHLIST_ADD_MESSAGE;
  final tRemoveMessage = WATCHLIST_REMOVE_MESSAGE;
  final tError = DatabaseException('Internal error');
  final tFailure = DatabaseFailure('Internal error');

  group('add watchlist', () {
    test('return success message when add successful', () async {
      when(mockWatchlistDataSource.insertWatchlist(tWatchlistModel))
          .thenAnswer((_) async => tAddMessage);

      final result = await repository.saveWatchlist(tWatchlistEntity);

      expect(result, Right(tAddMessage));
    });

    test('return DatabaseFailure when add unsuccessful', () async {
      when(mockWatchlistDataSource.insertWatchlist(tWatchlistModel))
          .thenThrow(tError);

      final result = await repository.saveWatchlist(tWatchlistEntity);

      expect(result, Left(tFailure));
    });
  });

  group('remove watchlist', () {
    test('return success message when remove successful', () async {
      when(mockWatchlistDataSource.removeWatchlist(tWatchlistModel.id))
          .thenAnswer((_) async => tRemoveMessage);

      final result = await repository.removeWatchlist(tWatchlistEntity.id);

      expect(result, Right(tRemoveMessage));
    });

    test('return DatabaseFailure when remove unsuccessful', () async {
      when(mockWatchlistDataSource.removeWatchlist(tWatchlistModel.id))
          .thenThrow(tError);

      final result = await repository.removeWatchlist(tWatchlistEntity.id);

      expect(result, Left(tFailure));
    });
  });

  group('get watchlist status', () {
    test('return watch status whether data is found', () async {
      when(mockWatchlistDataSource.getWatchlistById(1))
          .thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlist(1);

      expect(result, false);
    });
  });

  group('get watchlist', () {
    test('return either list of watchlist', () async {
      when(mockWatchlistDataSource.getWatchlist())
          .thenAnswer((_) async => [tWatchlistModel]);

      final result = await repository.getWatchlist();

      final resultList = result.getOrElse(() => []);
      expect(resultList, [tWatchlistEntity]);
    });

    test('return either Failure', () async {
      when(mockWatchlistDataSource.getWatchlist()).thenThrow(tError);

      final actual = await repository.getWatchlist();

      expect(actual, Left(tFailure));
    });
  });
}
