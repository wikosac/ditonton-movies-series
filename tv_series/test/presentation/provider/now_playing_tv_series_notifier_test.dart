import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tv_series/presentation/provider/now_playing_tv_series_notifier.dart';

import '../../dummy/dummy_objects.dart';
import 'now_playing_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late NowPlayingTvSeriesNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    provider = NowPlayingTvSeriesNotifier(mockGetNowPlayingTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tSearchList = [dummyTvSeries];

  test('return error state', () async {
    when(mockGetNowPlayingTvSeries.call())
        .thenAnswer((_) async => Left(ServerFailure('Server error')));

    await provider.fetchNowPlayingTvSeries();

    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server error');
    expect(listenerCallCount, 2);
  });

  test('return loading state', () async {
    when(mockGetNowPlayingTvSeries.call())
        .thenAnswer((_) async => Right(tSearchList));

    provider.fetchNowPlayingTvSeries();

    expect(provider.state, RequestState.Loading);
  });

  test('return loaded state', () async {
    when(mockGetNowPlayingTvSeries.call())
        .thenAnswer((_) async => Right(tSearchList));

    await provider.fetchNowPlayingTvSeries();

    expect(provider.state, RequestState.Loaded);
    expect(provider.tvSeries, tSearchList);
    expect(listenerCallCount, 2);
  });
}
