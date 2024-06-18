import 'package:dartz/dartz.dart';
import 'package:ditonton/core/errors/failure.dart';
import 'package:ditonton/core/utils/state_enum.dart';
import 'package:ditonton/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/tv_series/presentation/provider/popular_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/dummy_objects.dart';
import 'popular_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    provider = PopularTvSeriesNotifier(mockGetPopularTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tSearchList = [dummyTvSeries];

  test('return error state', () async {
    when(mockGetPopularTvSeries.call())
        .thenAnswer((_) async => Left(ServerFailure('Server error')));

    await provider.fetchPopularTvSeries();

    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server error');
    expect(listenerCallCount, 2);
  });

  test('return loading state', () async {
    when(mockGetPopularTvSeries.call())
        .thenAnswer((_) async => Right(tSearchList));

    provider.fetchPopularTvSeries();

    expect(provider.state, RequestState.Loading);
  });

  test('return loaded state', () async {
    when(mockGetPopularTvSeries.call())
        .thenAnswer((_) async => Right(tSearchList));

    await provider.fetchPopularTvSeries();

    expect(provider.state, RequestState.Loaded);
    expect(provider.tvSeries, tSearchList);
    expect(listenerCallCount, 2);
  });
}
