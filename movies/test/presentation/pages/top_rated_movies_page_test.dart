import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/cubit/top_rated_movies_cubit.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesCubit])
void main() {
  late MockTopRatedMoviesCubit mockCubit;

  setUp(() {
    mockCubit = MockTopRatedMoviesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tLoading = TopRatedMoviesLoading();
  final tLoaded = TopRatedMoviesLoaded(testMovieList);
  const tError = TopRatedMoviesError('Server error');

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tLoading),
    );
    when(mockCubit.state).thenReturn(tLoading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tLoaded),
    );
    when(mockCubit.state).thenReturn(tLoaded);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tError),
    );
    when(mockCubit.state).thenReturn(tError);

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
