import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

import '../../dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepository repository;
  late MockTvSeriesRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockTvSeriesRemoteDataSource();
    repository =
        TvSeriesRepositoryImpl(tvSeriesRemoteDataSource: mockDataSource);
  });

  final tTvResponse = dummyTvResponse;
  final tTvData = [dummyTvSeries];
  final tDetailResponse = dummyTvDetailResponse;
  final tDetailData = dummyTvSeriesDetail;
  final tSeasonResponse = dummySeasonResponse;
  final tEpisodeData = [dummyEpisode];
  final tError = ServerException(message: 'Server error');

  group('now playing', () {
    test('return either List<TvSeries> when success', () async {
      when(mockDataSource.getNowPlayingTvSeries())
          .thenAnswer((_) async => tTvResponse);

      final actual = await repository.getNowPlayingTvSeries();
      final resultList = actual.getOrElse(() => []);

      expect(resultList, tTvData);
      verify(mockDataSource.getNowPlayingTvSeries()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('return either Failure when unsuccessful', () async {
      when(mockDataSource.getNowPlayingTvSeries()).thenThrow(tError);

      final actual = await repository.getNowPlayingTvSeries();

      expect(actual, Left(ServerFailure(tError.message)));
      verify(mockDataSource.getNowPlayingTvSeries()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('popular', () {
    test('return either List<TvSeries> when success', () async {
      when(mockDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvResponse);

      final actual = await repository.getPopularTvSeries();
      final resultList = actual.getOrElse(() => []);

      expect(resultList, tTvData);
      verify(mockDataSource.getPopularTvSeries()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('return either Failure when unsuccessful', () async {
      when(mockDataSource.getPopularTvSeries()).thenThrow(tError);

      final actual = await repository.getPopularTvSeries();

      expect(actual, Left(ServerFailure(tError.message)));
      verify(mockDataSource.getPopularTvSeries()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('top rated', () {
    test('return either List<TvSeries> when success', () async {
      when(mockDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvResponse);

      final actual = await repository.getTopRatedTvSeries();
      final resultList = actual.getOrElse(() => []);

      expect(resultList, tTvData);
      verify(mockDataSource.getTopRatedTvSeries()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('return either Failure when unsuccessful', () async {
      when(mockDataSource.getTopRatedTvSeries()).thenThrow(tError);

      final actual = await repository.getTopRatedTvSeries();

      expect(actual, Left(ServerFailure(tError.message)));
      verify(mockDataSource.getTopRatedTvSeries()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('detail', () {
    test('return either TvDetail when success', () async {
      when(mockDataSource.getTvSeriesDetail(1))
          .thenAnswer((_) async => tDetailResponse);

      final actual = await repository.getTvSeriesDetail(1);
      final resultList = actual.getOrElse(() => tDetailData);

      expect(resultList, tDetailData);
      verify(mockDataSource.getTvSeriesDetail(1)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('return either Failure when unsuccessful', () async {
      when(mockDataSource.getTvSeriesDetail(1)).thenThrow(tError);

      final actual = await repository.getTvSeriesDetail(1);

      expect(actual, Left(ServerFailure(tError.message)));
      verify(mockDataSource.getTvSeriesDetail(1)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('recommendations', () {
    test('return either List<TvSeries> when success', () async {
      when(mockDataSource.getTvSeriesRecommendations(1))
          .thenAnswer((_) async => tTvResponse);

      final actual = await repository.getTvSeriesRecommendations(1);
      final resultList = actual.getOrElse(() => []);

      expect(resultList, tTvData);
      verify(mockDataSource.getTvSeriesRecommendations(1)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('return either Failure when unsuccessful', () async {
      when(mockDataSource.getTvSeriesRecommendations(1)).thenThrow(tError);

      final actual = await repository.getTvSeriesRecommendations(1);

      expect(actual, Left(ServerFailure(tError.message)));
      verify(mockDataSource.getTvSeriesRecommendations(1)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('season', () {
    test('return either List<Episode> when success', () async {
      when(mockDataSource.getTvSeriesSeason(1, 2))
          .thenAnswer((_) async => tSeasonResponse);

      final actual = await repository.getTvSeriesSeason(1, 2);
      final resultList = actual.getOrElse(() => []);

      expect(resultList, tEpisodeData);
      verify(mockDataSource.getTvSeriesSeason(1, 2)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('return either Failure when unsuccessful', () async {
      when(mockDataSource.getTvSeriesSeason(1, 2)).thenThrow(tError);

      final actual = await repository.getTvSeriesSeason(1, 2);

      expect(actual, Left(ServerFailure(tError.message)));
      verify(mockDataSource.getTvSeriesSeason(1, 2)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });
}
