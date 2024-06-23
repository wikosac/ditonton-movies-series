import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_season.dart';

import '../../dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesSeason usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesSeason(mockRepository);
  });

  final tData = [dummyEpisode];

  test('return either List<TvSeries>', () async {
    when(mockRepository.getTvSeriesSeason(1, 2))
        .thenAnswer((_) async => Right(tData));

    final result = await usecase.call(1, 2);

    expect(result, Right(tData));
    verify(usecase.call(1, 2)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
