import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetNowPlayingTvSeries(mockRepository);
  });

  final tSearchList = [dummyTvSeries];

  test('return either List<TvSeries>', () async {
    when(mockRepository.getNowPlayingTvSeries())
        .thenAnswer((_) async => Right(tSearchList));

    final result = await usecase.call();

    expect(result, Right(tSearchList));
    verify(usecase.call()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
