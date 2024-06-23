import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';

import '../../dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockRepository);
  });

  final tData = dummyTvSeriesDetail;

  test('return either List<TvSeries>', () async {
    when(mockRepository.getTvSeriesDetail(1))
        .thenAnswer((_) async => Right(tData));

    final result = await usecase.call(1);

    expect(result, Right(tData));
    verify(usecase.call(1)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
