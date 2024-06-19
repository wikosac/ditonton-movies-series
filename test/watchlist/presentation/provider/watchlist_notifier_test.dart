import 'package:dartz/dartz.dart';
import 'package:ditonton/core/errors/failure.dart';
import 'package:ditonton/core/utils/state_enum.dart';
import 'package:ditonton/watchlist/domain/usecases/get_watchlist.dart';
import 'package:ditonton/watchlist/presentation/provider/watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/dummy_objects.dart';
import 'watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlist])
void main() {
  late MockGetWatchlist mockGetWatchlist;
  late WatchlistNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlist = MockGetWatchlist();
    provider = WatchlistNotifier(mockGetWatchlist)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tWatchlist = [dummyWatchlist];
  final tFailure = DatabaseFailure('Internal error');

  test('return error state', () async {
    when(mockGetWatchlist.execute())
        .thenAnswer((_) async => Left(tFailure));

    await provider.fetchWatchlistMovies();

    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, tFailure.message);
    expect(listenerCallCount, 2);
  });

  test('return loading state', () async {
    when(mockGetWatchlist.execute()).thenAnswer((_) async => Right(tWatchlist));

    provider.fetchWatchlistMovies();

    expect(provider.watchlistState, RequestState.Loading);
  });

  test('return loaded state', () async {
    when(mockGetWatchlist.execute()).thenAnswer((_) async => Right(tWatchlist));

    await provider.fetchWatchlistMovies();

    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlist, tWatchlist);
    expect(listenerCallCount, 2);
  });
}
