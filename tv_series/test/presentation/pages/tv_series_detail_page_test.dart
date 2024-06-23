
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/presentation/provider/tv_series_detail_notifier.dart';
import 'package:tv_series/presentation/provider/tv_series_season_notifier.dart';
import 'package:tv_series/presentation/widgets/episode_card_list.dart';

import '../../dummy/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailNotifier, TvSeriesSeasonNotifier])
void main() {
  late MockTvSeriesDetailNotifier mockDetailNotifier;
  late MockTvSeriesSeasonNotifier mockSeasonNotifier;

  setUp(() {
    mockDetailNotifier = MockTvSeriesDetailNotifier();
    mockSeasonNotifier = MockTvSeriesSeasonNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TvSeriesDetailNotifier>.value(
            value: mockDetailNotifier),
        ChangeNotifierProvider<TvSeriesSeasonNotifier>.value(
            value: mockSeasonNotifier),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('display add icon when item is not watchlist',
      (WidgetTester tester) async {
    when(mockDetailNotifier.detailState).thenReturn(RequestState.Loaded);
    when(mockDetailNotifier.series).thenReturn(dummyTvSeriesDetail);
    when(mockDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockDetailNotifier.seriesRecommendations).thenReturn([dummyTvSeries]);
    when(mockDetailNotifier.isWatchlist).thenReturn(false);
    when(mockSeasonNotifier.episodeState).thenReturn(RequestState.Loaded);
    when(mockSeasonNotifier.episodes).thenReturn([dummyEpisode]);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('display check icon when item is watchlist',
      (WidgetTester tester) async {
    when(mockDetailNotifier.detailState).thenReturn(RequestState.Loaded);
    when(mockDetailNotifier.series).thenReturn(dummyTvSeriesDetail);
    when(mockDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockDetailNotifier.seriesRecommendations).thenReturn([dummyTvSeries]);
    when(mockDetailNotifier.isWatchlist).thenReturn(true);
    when(mockSeasonNotifier.episodeState).thenReturn(RequestState.Loaded);
    when(mockSeasonNotifier.episodes).thenReturn([dummyEpisode]);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('display snackbar when item added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailNotifier.detailState).thenReturn(RequestState.Loaded);
    when(mockDetailNotifier.series).thenReturn(dummyTvSeriesDetail);
    when(mockDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockDetailNotifier.seriesRecommendations).thenReturn([dummyTvSeries]);
    when(mockDetailNotifier.isWatchlist).thenReturn(false);
    when(mockDetailNotifier.watchlistMessage).thenReturn('Added to Watchlist');
    when(mockSeasonNotifier.episodeState).thenReturn(RequestState.Loaded);
    when(mockSeasonNotifier.episodes).thenReturn([dummyEpisode]);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets('display AlertDialog when failed', (WidgetTester tester) async {
    when(mockDetailNotifier.detailState).thenReturn(RequestState.Loaded);
    when(mockDetailNotifier.series).thenReturn(dummyTvSeriesDetail);
    when(mockDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockDetailNotifier.seriesRecommendations).thenReturn([dummyTvSeries]);
    when(mockDetailNotifier.isWatchlist).thenReturn(false);
    when(mockDetailNotifier.watchlistMessage).thenReturn('Failed');
    when(mockSeasonNotifier.episodeState).thenReturn(RequestState.Loaded);
    when(mockSeasonNotifier.episodes).thenReturn([dummyEpisode]);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('display list season and episode', (WidgetTester tester) async {
    when(mockDetailNotifier.detailState).thenReturn(RequestState.Loaded);
    when(mockDetailNotifier.series).thenReturn(dummyTvSeriesDetail);
    when(mockDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockDetailNotifier.seriesRecommendations).thenReturn([dummyTvSeries]);
    when(mockDetailNotifier.isWatchlist).thenReturn(false);
    when(mockDetailNotifier.watchlistMessage).thenReturn('Added to Watchlist');
    when(mockSeasonNotifier.episodeState).thenReturn(RequestState.Loaded);
    when(mockSeasonNotifier.episodes).thenReturn([dummyEpisode]);

    final episodeWidget = find.byType(EpisodeCardList);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(episodeWidget, findsOneWidget);
  });
}
