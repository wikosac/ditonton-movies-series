import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/cubit/popular_tv_cubit.dart';
import 'package:tv_series/presentation/pages/popular_tv_series_page.dart';

import '../../dummy/dummy_objects.dart';
import 'popular_tv_series_page_test.mocks.dart';

@GenerateMocks([PopularTvCubit])
void main() {
  late MockPopularTvCubit mockCubit;

  setUp(() {
    mockCubit = MockPopularTvCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tLoading = PopularTvLoading();
  final tLoaded = PopularTvLoaded([dummyTvSeries]);
  const tError = PopularTvError('Server error');

  testWidgets('page should display loading indicator', (widgetTester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tLoading),
    );
    when(mockCubit.state).thenReturn(tLoading);

    final progressBar = find.byType(CircularProgressIndicator);

    await widgetTester
        .pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

    expect(progressBar, findsOneWidget);
  });

  testWidgets('page should display error', (widgetTester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tError),
    );
    when(mockCubit.state).thenReturn(tError);

    final textWidget = find.byKey(const Key('error_message'));

    await widgetTester
        .pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

    expect(textWidget, findsOneWidget);
  });

  testWidgets('page should display list of data', (widgetTester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tLoaded),
    );
    when(mockCubit.state).thenReturn(tLoaded);

    final listView = find.byType(AlignedGridView);

    await widgetTester
        .pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

    expect(listView, findsOneWidget);
  });
}
