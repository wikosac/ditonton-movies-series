import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy/dummy_objects.dart';
import 'watchlist_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlist,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetWatchlist mockGetWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late WatchlistCubit watchlistCubit;

  setUp(() {
    mockGetWatchlist = MockGetWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistCubit = WatchlistCubit(
      mockGetWatchlist,
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  const tData = dummyWatchlist;

  group('Get Watchlist', () {
    test('initial state should be initial', () {
      expect(watchlistCubit.state, WatchlistInitial());
    });

    blocTest<WatchlistCubit, WatchlistState>(
      'return List<Watchlist> when usecase called',
      build: () {
        when(mockGetWatchlist.execute())
            .thenAnswer((_) async => const Right([tData]));
        return watchlistCubit;
      },
      act: (cubit) => cubit.fetchWatchlist(),
      verify: (cubit) => mockGetWatchlist.execute(),
    );

    blocTest<WatchlistCubit, WatchlistState>(
      'return loaded state when successful',
      build: () {
        when(mockGetWatchlist.execute())
            .thenAnswer((_) async => const Right([tData]));
        return watchlistCubit;
      },
      act: (cubit) => cubit.fetchWatchlist(),
      expect: () => [
        WatchlistLoading(),
        const WatchlistLoaded([tData]),
      ],
      verify: (cubit) => mockGetWatchlist.execute(),
    );

    blocTest<WatchlistCubit, WatchlistState>(
      'return error state when unsuccessful',
      build: () {
        when(mockGetWatchlist.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('Internal error')));
        return watchlistCubit;
      },
      act: (cubit) => cubit.fetchWatchlist(),
      expect: () => [
        WatchlistLoading(),
        const WatchlistError('Internal error'),
      ],
      verify: (cubit) => mockGetWatchlist.execute(),
    );
  });

  group('Watchlist  Status', () {
    blocTest<WatchlistCubit, WatchlistState>(
      'return watchlist status state',
      build: () {
        when(mockGetWatchListStatus.execute(tData.id))
            .thenAnswer((_) async => true);
        return watchlistCubit;
      },
      act: (cubit) => cubit.checkWatchlistStatus(tData.id),
      expect: () => [const WatchlistStatus(true)],
    );
  });

  group('Add Watchlist', () {
    blocTest<WatchlistCubit, WatchlistState>(
      'return success message when usecase called',
      build: () {
        when(mockSaveWatchlist.execute(tData))
            .thenAnswer((_) async => const Right(WATCHLIST_ADD_MESSAGE));
        when(mockGetWatchListStatus.execute(tData.id))
            .thenAnswer((_) async => true);
        return watchlistCubit;
      },
      act: (cubit) => cubit.addWatchlist(tData),
      verify: (cubit) => mockSaveWatchlist.execute(tData),
    );

    blocTest<WatchlistCubit, WatchlistState>(
      'return success state when successful',
      build: () {
        when(mockGetWatchListStatus.execute(tData.id))
            .thenAnswer((_) async => true);
        when(mockSaveWatchlist.execute(tData))
            .thenAnswer((_) async => const Right(WATCHLIST_ADD_MESSAGE));
        return watchlistCubit;
      },
      act: (cubit) => cubit.addWatchlist(tData),
      expect: () => [
        const WatchlistSuccess(WATCHLIST_ADD_MESSAGE),
        const WatchlistStatus(true),
      ],
      verify: (cubit) => mockSaveWatchlist.execute(tData),
    );

    blocTest<WatchlistCubit, WatchlistState>(
      'return error state when unsuccessful',
      build: () {
        when(mockGetWatchListStatus.execute(tData.id))
            .thenAnswer((_) async => false);
        when(mockSaveWatchlist.execute(tData))
            .thenAnswer((_) async => Left(DatabaseFailure('Internal error')));
        return watchlistCubit;
      },
      act: (cubit) => cubit.addWatchlist(tData),
      expect: () => [
        const WatchlistError('Internal error'),
        const WatchlistStatus(false),
      ],
      verify: (cubit) => mockSaveWatchlist.execute(tData),
    );
  });

  group('Remove Watchlist', () {
    blocTest<WatchlistCubit, WatchlistState>(
      'execute usecase when called',
      build: () {
        when(mockRemoveWatchlist.execute(tData.id))
            .thenAnswer((_) async => const Right('Removed from Watchlist s'));
        when(mockGetWatchListStatus.execute(tData.id))
            .thenAnswer((_) async => false);

        return watchlistCubit;
      },
      act: (cubit) => cubit.removeWatchlist(tData.id),
      verify: (cubit) => verify(mockRemoveWatchlist.execute(tData.id)),
    );

    blocTest<WatchlistCubit, WatchlistState>(
      'return success state when successful',
      build: () {
        when(mockRemoveWatchlist.execute(tData.id))
            .thenAnswer((_) async => const Right('Removed from Watchlist s'));
        when(mockGetWatchListStatus.execute(tData.id))
            .thenAnswer((_) async => false);

        return watchlistCubit;
      },
      act: (cubit) => cubit.removeWatchlist(tData.id),
      expect: () => [
        const WatchlistSuccess('Removed from Watchlist s'),
        const WatchlistStatus(false),
      ],
      verify: (cubit) {
        verify(mockRemoveWatchlist.execute(tData.id));
        verify(mockGetWatchListStatus.execute(tData.id));
      },
    );

    blocTest<WatchlistCubit, WatchlistState>(
      'return error state when unsuccessful',
      build: () {
        when(mockRemoveWatchlist.execute(tData.id))
            .thenAnswer((_) async => Left(DatabaseFailure('Internal error')));
        when(mockGetWatchListStatus.execute(tData.id))
            .thenAnswer((_) async => false);

        return watchlistCubit;
      },
      act: (cubit) => cubit.removeWatchlist(tData.id),
      expect: () => [
        const WatchlistError('Internal error'),
        const WatchlistStatus(false),
      ],
      verify: (cubit) {
        verify(mockRemoveWatchlist.execute(tData.id));
        verify(mockGetWatchListStatus.execute(tData.id));
      },
    );
  });
}
