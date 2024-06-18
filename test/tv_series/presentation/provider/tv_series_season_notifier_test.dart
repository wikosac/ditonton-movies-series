import 'package:dartz/dartz.dart';
import 'package:ditonton/core/errors/failure.dart';
import 'package:ditonton/core/utils/state_enum.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tv_series_season.dart';
import 'package:ditonton/tv_series/presentation/provider/tv_series_season_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/dummy_objects.dart';
import 'tv_series_season_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesSeason])
void main() {
  late TvSeriesSeasonNotifier provider;
  late MockGetTvSeriesSeason mockGetTvSeriesSeason;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesSeason = MockGetTvSeriesSeason();
    provider = TvSeriesSeasonNotifier(mockGetTvSeriesSeason)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tEpisodeList = [dummyEpisode];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.episodeState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvSeriesSeason.call(1, 2))
          .thenAnswer((_) async => Right(tEpisodeList));
      // act
      provider.fetchTvSeriesSeason(1, 2);
      // assert
      verify(mockGetTvSeriesSeason.call(1, 2));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTvSeriesSeason.call(1, 2))
          .thenAnswer((_) async => Right(tEpisodeList));
      // act
      provider.fetchTvSeriesSeason(1, 2);
      // assert
      expect(provider.episodeState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetTvSeriesSeason.call(1, 2))
          .thenAnswer((_) async => Right(tEpisodeList));
      // act
      await provider.fetchTvSeriesSeason(1, 2);
      // assert
      expect(provider.episodeState, RequestState.Loaded);
      expect(provider.episodes, tEpisodeList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesSeason.call(1, 2))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeriesSeason(1, 2);
      // assert
      expect(provider.episodeState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
