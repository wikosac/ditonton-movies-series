import 'package:ditonton/core/utils/state_enum.dart';
import 'package:ditonton/tv_series/presentation/pages/now_playing_tv_series_page.dart';
import 'package:ditonton/tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/tv_series/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy/dummy_objects.dart';
import 'top_rated_tv_series_page_test.mocks.dart';

@GenerateMocks([TopRatedTvSeriesNotifier])
void main() {
  late MockTopRatedTvSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvSeriesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display loading indicator', (widgetTester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressBar = find.byType(CircularProgressIndicator);

    await widgetTester
        .pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(progressBar, findsOneWidget);
  });

  testWidgets('page should display error', (widgetTester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Server error');

    final textWidget = find.byKey(Key('error_message'));

    await widgetTester
        .pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(textWidget, findsOneWidget);
  });

  testWidgets('page should display list of data', (widgetTester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn([dummyTvSeries]);

    final listView = find.byType(AlignedGridView);

    await widgetTester
        .pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(listView, findsOneWidget);
  });
}
