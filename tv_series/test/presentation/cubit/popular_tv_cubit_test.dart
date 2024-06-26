import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy/dummy_objects.dart';
import 'popular_tv_cubit_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvCubit cubit;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    cubit = PopularTvCubit(mockGetPopularTvSeries);
  });

  test('should emit initial state', () {
    expect(cubit.state, PopularTvInitial());
  });

  blocTest<PopularTvCubit, PopularTvState>(
    'return List<TvSeries> when usecase called',
    build: () {
      when(mockGetPopularTvSeries.call())
          .thenAnswer((_) async => Right([dummyTvSeries]));
      return cubit;
    },
    act: (cubit) => cubit.fetchPopularTvSeries(),
    verify: (cubit) => mockGetPopularTvSeries.call(),
  );

  blocTest<PopularTvCubit, PopularTvState>(
    'return loaded state when successful',
    build: () {
      when(mockGetPopularTvSeries.call())
          .thenAnswer((_) async => Right([dummyTvSeries]));
      return cubit;
    },
    act: (cubit) => cubit.fetchPopularTvSeries(),
    expect: () => [
      PopularTvLoading(),
      PopularTvLoaded([dummyTvSeries]),
    ],
    verify: (cubit) => mockGetPopularTvSeries.call(),
  );

  blocTest<PopularTvCubit, PopularTvState>(
    'return error state when unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.call())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return cubit;
    },
    act: (cubit) => cubit.fetchPopularTvSeries(),
    expect: () => [
      PopularTvLoading(),
      const PopularTvError('Server Failure'),
    ],
    verify: (cubit) => mockGetPopularTvSeries.call(),
  );
}
