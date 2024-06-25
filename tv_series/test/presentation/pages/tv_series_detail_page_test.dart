import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/cubit/tv_detail_cubit.dart';
import 'package:tv_series/presentation/cubit/tv_season_cubit.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/presentation/widgets/episode_card_list.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailCubit, TvSeasonCubit, WatchlistCubit])
void main() {
  late MockTvDetailCubit mockDetailCubit;
  late MockTvSeasonCubit mockSeasonCubit;
  late MockWatchlistCubit mockWatchlistCubit;

  setUp(() {
    mockDetailCubit = MockTvDetailCubit();
    mockSeasonCubit = MockTvSeasonCubit();
    mockWatchlistCubit = MockWatchlistCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailCubit>.value(value: mockDetailCubit),
        BlocProvider<TvSeasonCubit>.value(value: mockSeasonCubit),
        BlocProvider<WatchlistCubit>.value(value: mockWatchlistCubit),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tDetailLoaded = TvDetailLoaded(dummyTvSeriesDetail, [dummyTvSeries]);
  final tSeasonLoaded = TvSeasonLoaded([dummyEpisode]);
  const tWatchlistStatusF = WatchlistStatus(false);
  const tWatchlistStatusT = WatchlistStatus(true);
  const tWatchlistSuccessA = WatchlistSuccess(WATCHLIST_ADD_MESSAGE);
  const tWatchlistSuccessE = WatchlistSuccess('Failed');

  testWidgets('display add icon when item is not watchlist',
      (WidgetTester tester) async {
    when(mockDetailCubit.stream).thenAnswer(
      (_) => Stream.value(tDetailLoaded),
    );
    when(mockDetailCubit.state).thenReturn(tDetailLoaded);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistStatusF),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistStatusF);
    when(mockSeasonCubit.stream).thenAnswer(
          (_) => Stream.value(tSeasonLoaded),
    );
    when(mockSeasonCubit.state).thenReturn(tSeasonLoaded);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('display check icon when item is watchlist',
      (WidgetTester tester) async {
    when(mockDetailCubit.stream).thenAnswer(
      (_) => Stream.value(tDetailLoaded),
    );
    when(mockDetailCubit.state).thenReturn(tDetailLoaded);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistStatusT),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistStatusT);
    when(mockSeasonCubit.stream).thenAnswer(
          (_) => Stream.value(tSeasonLoaded),
    );
    when(mockSeasonCubit.state).thenReturn(tSeasonLoaded);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('display snackbar when item added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailCubit.stream).thenAnswer(
      (_) => Stream.value(tDetailLoaded),
    );
    when(mockDetailCubit.state).thenReturn(tDetailLoaded);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistStatusF),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistStatusF);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistSuccessA),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistSuccessA);
    when(mockSeasonCubit.stream).thenAnswer(
          (_) => Stream.value(tSeasonLoaded),
    );
    when(mockSeasonCubit.state).thenReturn(tSeasonLoaded);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets('display AlertDialog when failed', (WidgetTester tester) async {
    when(mockDetailCubit.stream).thenAnswer(
      (_) => Stream.value(tDetailLoaded),
    );
    when(mockDetailCubit.state).thenReturn(tDetailLoaded);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistStatusF),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistStatusF);
    when(mockWatchlistCubit.stream).thenAnswer(
      (_) => Stream.value(tWatchlistSuccessE),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistSuccessE);
    when(mockSeasonCubit.stream).thenAnswer(
          (_) => Stream.value(tSeasonLoaded),
    );
    when(mockSeasonCubit.state).thenReturn(tSeasonLoaded);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('display list season and episode', (WidgetTester tester) async {
    when(mockDetailCubit.stream).thenAnswer(
      (_) => Stream.value(tDetailLoaded),
    );
    when(mockDetailCubit.state).thenReturn(tDetailLoaded);
    when(mockWatchlistCubit.stream).thenAnswer(
          (_) => Stream.value(tWatchlistStatusF),
    );
    when(mockWatchlistCubit.state).thenReturn(tWatchlistStatusF);
    when(mockSeasonCubit.stream).thenAnswer(
      (_) => Stream.value(tSeasonLoaded),
    );
    when(mockSeasonCubit.state).thenReturn(tSeasonLoaded);

    final episodeWidget = find.byType(EpisodeCardList);

    await tester.pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(episodeWidget, findsOneWidget);
  });
}
