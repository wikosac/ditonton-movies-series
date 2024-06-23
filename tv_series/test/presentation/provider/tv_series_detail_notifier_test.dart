import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/presentation/provider/tv_series_detail_notifier.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    provider = TvSeriesDetailNotifier(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeriesList = [dummyTvSeries];
  final tTvSeriesDetail = dummyTvSeriesDetail;

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.call(1))
        .thenAnswer((_) async => Right(dummyTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.call(1))
        .thenAnswer((_) async => Right(tTvSeriesList));
  }

  group('Get TvSeries Detail', () {
    test('should get data from the usecase', () async {
      _arrangeUsecase();

      await provider.fetchTvSeriesDetail(1);

      verify(mockGetTvSeriesDetail.call(1));
      verify(mockGetTvSeriesRecommendations.call(1));
    });

    test('should change state to Loading when usecase is called', () {
      _arrangeUsecase();

      provider.fetchTvSeriesDetail(1);

      expect(provider.detailState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change series when data is gotten successfully', () async {
      _arrangeUsecase();

      await provider.fetchTvSeriesDetail(1);

      expect(provider.detailState, RequestState.Loaded);
      expect(provider.series, tTvSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation seriess when data is gotten successfully',
        () async {
      _arrangeUsecase();

      await provider.fetchTvSeriesDetail(1);

      expect(provider.detailState, RequestState.Loaded);
      expect(provider.seriesRecommendations, tTvSeriesList);
    });
  });

  group('Get TvSeries Recommendations', () {
    test('should get data from the usecase', () async {
      _arrangeUsecase();

      await provider.fetchTvSeriesDetail(1);

      verify(mockGetTvSeriesRecommendations.call(1));
      expect(provider.seriesRecommendations, tTvSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      _arrangeUsecase();

      await provider.fetchTvSeriesDetail(1);

      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.seriesRecommendations, tTvSeriesList);
    });

    test('should update error message when request in successful', () async {
      when(mockGetTvSeriesDetail.call(1))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      when(mockGetTvSeriesRecommendations.call(1))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      await provider.fetchTvSeriesDetail(1);

      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);

      await provider.loadWatchlistStatus(1);

      expect(provider.isWatchlist, true);
    });

    test('should call save watchlist when function called', () async {
      when(mockSaveWatchlist.execute(tTvSeriesDetail.toWatchlist()))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(tTvSeriesDetail.id))
          .thenAnswer((_) async => true);

      await provider.addWatchlist(tTvSeriesDetail);

      verify(mockSaveWatchlist.execute(tTvSeriesDetail.toWatchlist()));
    });

    test('should call remove watchlist when function called', () async {
      when(mockRemoveWatchlist.execute(tTvSeriesDetail.id))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(tTvSeriesDetail.id))
          .thenAnswer((_) async => false);

      await provider.removeFromWatchlist(tTvSeriesDetail);

      verify(mockRemoveWatchlist.execute(tTvSeriesDetail.id));
    });

    test('should update watchlist status when add watchlist success', () async {
      when(mockSaveWatchlist.execute(tTvSeriesDetail.toWatchlist()))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(tTvSeriesDetail.id))
          .thenAnswer((_) async => true);

      await provider.addWatchlist(tTvSeriesDetail);

      verify(mockGetWatchlistStatus.execute(tTvSeriesDetail.id));
      expect(provider.isWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      when(mockSaveWatchlist.execute(tTvSeriesDetail.toWatchlist()))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(tTvSeriesDetail.id))
          .thenAnswer((_) async => false);

      await provider.addWatchlist(tTvSeriesDetail);

      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when remove watchlist failed', () async {
      when(mockRemoveWatchlist.execute(tTvSeriesDetail.id))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(tTvSeriesDetail.id))
          .thenAnswer((_) async => true);

      await provider.removeFromWatchlist(tTvSeriesDetail);

      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      when(mockGetTvSeriesDetail.call(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvSeriesRecommendations.call(1))
          .thenAnswer((_) async => Right(tTvSeriesList));

      await provider.fetchTvSeriesDetail(1);

      expect(provider.detailState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
