import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/presentation/provider/tv_series_list_notifier.dart';

import '../../dummy/dummy_objects.dart';
import 'now_playing_tv_series_notifier_test.mocks.dart';
import 'popular_tv_series_notifier_test.mocks.dart';
import 'top_rated_tv_series_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider = TvSeriesListNotifier(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeriesList = [dummyTvSeries];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      when(mockGetNowPlayingTvSeries.call())
          .thenAnswer((_) async => Right(tTvSeriesList));

      provider.fetchNowPlayingTvSeries();

      verify(mockGetNowPlayingTvSeries.call());
    });

    test('should change state to Loading when usecase is called', () {
      when(mockGetNowPlayingTvSeries.call())
          .thenAnswer((_) async => Right(tTvSeriesList));

      provider.fetchNowPlayingTvSeries();

      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      when(mockGetNowPlayingTvSeries.call())
          .thenAnswer((_) async => Right(tTvSeriesList));

      await provider.fetchNowPlayingTvSeries();

      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetNowPlayingTvSeries.call())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchNowPlayingTvSeries();

      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetPopularTvSeries.call())
          .thenAnswer((_) async => Right(tTvSeriesList));

      provider.fetchPopularTvSeries();

      expect(provider.popularTvSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      when(mockGetPopularTvSeries.call())
          .thenAnswer((_) async => Right(tTvSeriesList));

      await provider.fetchPopularTvSeries();

      expect(provider.popularTvSeriesState, RequestState.Loaded);
      expect(provider.popularTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetPopularTvSeries.call())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchPopularTvSeries();

      expect(provider.popularTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetTopRatedTvSeries.call())
          .thenAnswer((_) async => Right(tTvSeriesList));

      provider.fetchTopRatedTvSeries();

      expect(provider.topRatedTvSeriesState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      when(mockGetTopRatedTvSeries.call())
          .thenAnswer((_) async => Right(tTvSeriesList));

      await provider.fetchTopRatedTvSeries();

      expect(provider.topRatedTvSeriesState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTopRatedTvSeries.call())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTopRatedTvSeries();

      expect(provider.topRatedTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
