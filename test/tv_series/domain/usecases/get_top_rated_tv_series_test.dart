import 'package:dartz/dartz.dart';
import 'package:ditonton/tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../dummy/dummy_objects.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockRepository);
  });

  final tSearchList = [dummyTvSeries];

  test('return either List<TvSeries>', () async {
    when(mockRepository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tSearchList));

    final result = await usecase.call();

    expect(result, Right(tSearchList));
    verify(usecase.call()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
