import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/presentation/cubit/watchlist_cubit.dart';
import 'package:watchlist/presentation/pages/watchlist_page.dart';

import '../../dummy/dummy_objects.dart';
import 'watchlist_page_test.mocks.dart';

@GenerateMocks([WatchlistCubit])
void main() {
  late MockWatchlistCubit mockCubit;

  setUp(() {
    mockCubit = MockWatchlistCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display loading indicator', (widgetTester) async {
    when(mockCubit.stream).thenAnswer((_) => Stream.value(WatchlistLoading()));
    when(mockCubit.state).thenReturn(WatchlistLoading());

    final progressBar = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(progressBar, findsOneWidget);
  });

  testWidgets('page should display error', (widgetTester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(WatchlistError('Server error')));
    when(mockCubit.state).thenReturn(WatchlistError('Server error'));

    final textWidget = find.byKey(const Key('error_message'));

    await widgetTester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(textWidget, findsOneWidget);
  });

  testWidgets('page should display list of data', (widgetTester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistLoaded([dummyWatchlist])));
    when(mockCubit.state).thenReturn(const WatchlistLoaded([dummyWatchlist]));

    final listView = find.byType(AlignedGridView);

    await widgetTester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(listView, findsOneWidget);
  });
}
