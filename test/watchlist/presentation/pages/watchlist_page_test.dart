import 'package:ditonton/core/utils/state_enum.dart';
import 'package:ditonton/watchlist/presentation/pages/watchlist_page.dart';
import 'package:ditonton/watchlist/presentation/provider/watchlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy/dummy_objects.dart';
import 'watchlist_page_test.mocks.dart';

@GenerateMocks([WatchlistNotifier])
void main() {
  late MockWatchlistNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display loading indicator', (widgetTester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Loading);

    final progressBar = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(progressBar, findsOneWidget);
  });

  testWidgets('page should display error', (widgetTester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Server error');

    final textWidget = find.byKey(Key('error_message'));

    await widgetTester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(textWidget, findsOneWidget);
  });

  testWidgets('page should display list of data', (widgetTester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
    when(mockNotifier.watchlist).thenReturn([dummyWatchlist]);

    final listView = find.byType(AlignedGridView);

    await widgetTester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(listView, findsOneWidget);
  });
}
