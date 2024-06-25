import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/cubit/movie_detail_cubit.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailCubit, WatchlistCubit])
void main() {
  late MockMovieDetailCubit mockCubit;
  late MockWatchlistCubit mockWatchlistCubit;

  setUp(() {
    mockCubit = MockMovieDetailCubit();
    mockWatchlistCubit = MockWatchlistCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailCubit>.value(
      value: mockCubit,
      child: BlocProvider<WatchlistCubit>.value(
        value: mockWatchlistCubit,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  final tDetailLoaded = MovieDetailLoaded(testMovieDetail, testMovieList);
  const tWatchlistStatusF = WatchlistStatus(false);
  const tWatchlistStatusT = WatchlistStatus(true);
  const tWatchlistSuccessA = WatchlistSuccess(WATCHLIST_ADD_MESSAGE);
  const tWatchlistSuccessE = WatchlistSuccess('Failed');

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tDetailLoaded),
    );
    when(mockCubit.state).thenReturn(tDetailLoaded);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistStatusF),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistStatusF);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tDetailLoaded),
    );
    when(mockCubit.state).thenReturn(tDetailLoaded);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistStatusT),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistStatusT);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tDetailLoaded),
    );
    when(mockCubit.state).thenReturn(tDetailLoaded);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistStatusF),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistStatusF);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistSuccessA),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistSuccessA);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tDetailLoaded),
    );
    when(mockCubit.state).thenReturn(tDetailLoaded);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistStatusF),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistStatusF);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistSuccessE),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistSuccessE);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
