
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/pages/tv_series_home_page.dart';
import 'package:tv_series/presentation/provider/tv_series_list_notifier.dart';

import '../../dummy/dummy_objects.dart';
import 'tv_series_home_page_test.mocks.dart';

@GenerateMocks([TvSeriesListNotifier])
void main() {
  late MockTvSeriesListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  group('now playing', () {
    testWidgets('page should display loading indicator', (widgetTester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loading);
      when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.message).thenReturn('');

      final progressBar = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeriesHomePage()));

      expect(progressBar, findsOneWidget);
    });

    testWidgets('page should display error', (widgetTester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Error);
      when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.message).thenReturn('Server error');

      final textWidget = find.bySemanticsLabel('text_info_1');

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeriesHomePage()));

      expect(textWidget, findsOneWidget);
    });

    testWidgets('page should display list of data', (widgetTester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
      when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.message).thenReturn('');
      when(mockNotifier.nowPlayingTvSeries).thenReturn([dummyTvSeries]);

      final listView = find.byType(TvSeriesList);

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeriesHomePage()));

      expect(listView, findsOneWidget);
    });
  });

  group('popular', () {
    testWidgets('page should display loading indicator', (widgetTester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Empty);
      when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Loading);
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.message).thenReturn('');

      final progressBar = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeriesHomePage()));

      expect(progressBar, findsOneWidget);
    });

    testWidgets('page should display error', (widgetTester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Empty);
      when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Error);
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.message).thenReturn('Server error');

      final textWidget = find.bySemanticsLabel('text_info_2');

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeriesHomePage()));

      expect(textWidget, findsOneWidget);
    });

    testWidgets('page should display list of data', (widgetTester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Empty);
      when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.message).thenReturn('');
      when(mockNotifier.popularTvSeries).thenReturn([dummyTvSeries]);

      final listView = find.byType(TvSeriesList);

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeriesHomePage()));

      expect(listView, findsOneWidget);
    });
  });

  group('top rated', () {
    testWidgets('page should display loading indicator', (widgetTester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Empty);
      when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Loading);
      when(mockNotifier.message).thenReturn('');

      final progressBar = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeriesHomePage()));

      expect(progressBar, findsOneWidget);
    });

    testWidgets('page should display error', (widgetTester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Empty);
      when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Server error');

      final textWidget = find.bySemanticsLabel('text_info_3');

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeriesHomePage()));

      expect(textWidget, findsOneWidget);
    });

    testWidgets('page should display list of data', (widgetTester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Empty);
      when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Empty);
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.message).thenReturn('');
      when(mockNotifier.topRatedTvSeries).thenReturn([dummyTvSeries]);

      final listView = find.byType(TvSeriesList);

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeriesHomePage()));

      expect(listView, findsOneWidget);
    });
  });
}
