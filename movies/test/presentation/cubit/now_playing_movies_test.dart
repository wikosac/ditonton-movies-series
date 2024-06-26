import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/presentation/cubit/now_playing_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMoviesCubit cubit;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    cubit = NowPlayingMoviesCubit(mockGetNowPlayingMovies);
  });

  test('initialState should be initial', () {
    expect(cubit.state, NowPlayingMoviesInitial());
  });

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'return List<Movie> when usecase called',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return cubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    verify: (cubit) => mockGetNowPlayingMovies.execute(),
  );

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'return loaded state when successful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return cubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesLoaded(testMovieList),
    ],
    verify: (cubit) => mockGetNowPlayingMovies.execute(),
  );

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'return error state when unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Error')));
      return cubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [
      NowPlayingMoviesLoading(),
      const NowPlayingMoviesError('Server Error'),
    ],
    verify: (cubit) => mockGetNowPlayingMovies.execute(),
  );
}
