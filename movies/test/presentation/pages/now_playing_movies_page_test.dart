import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/cubit/now_playing_movies_cubit.dart';
import 'package:movies/presentation/pages/now_playing_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_page_test.mocks.dart';

@GenerateMocks([NowPlayingMoviesCubit])
void main() {
  late MockNowPlayingMoviesCubit mockCubit;

  setUp(() {
    mockCubit = MockNowPlayingMoviesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingMoviesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tLoading = NowPlayingMoviesLoading();
  final tLoaded = NowPlayingMoviesLoaded(testMovieList);
  const tError = NowPlayingMoviesError('Server error');

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tLoading),
    );
    when(mockCubit.state).thenReturn(tLoading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tLoaded),
    );
    when(mockCubit.state).thenReturn(tLoaded);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tError),
    );
    when(mockCubit.state).thenReturn(tError);

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
