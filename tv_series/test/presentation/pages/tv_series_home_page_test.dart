import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy/dummy_objects.dart';
import 'tv_series_home_page_test.mocks.dart';

@GenerateMocks([NowPlayingTvCubit, PopularTvCubit, TopRatedTvCubit])
void main() {
  late MockNowPlayingTvCubit mockNowPlayingTvCubit;
  late MockPopularTvCubit mockPopularTvCubit;
  late MockTopRatedTvCubit mockTopRatedTvCubit;

  setUp(() {
    mockNowPlayingTvCubit = MockNowPlayingTvCubit();
    mockPopularTvCubit = MockPopularTvCubit();
    mockTopRatedTvCubit = MockTopRatedTvCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvCubit>.value(value: mockNowPlayingTvCubit),
        BlocProvider<PopularTvCubit>.value(value: mockPopularTvCubit),
        BlocProvider<TopRatedTvCubit>.value(value: mockTopRatedTvCubit),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  final tNowPlayingLoading = NowPlayingTvLoading();
  final tNowPlayingLoaded = NowPlayingTvLoaded([dummyTvSeries]);
  const tNowPlayingError = NowPlayingTvError('Server error');
  final tPopularLoading = PopularTvLoading();
  final tPopularLoaded = PopularTvLoaded([dummyTvSeries]);
  const tPopularError = PopularTvError('Server error');
  final tTopRatedLoading = TopRatedTvLoading();
  final tTopRatedLoaded = TopRatedTvLoaded([dummyTvSeries]);
  const tTopRatedError = TopRatedTvError('Server error');

  group('now playing', () {
    testWidgets('page should display loading indicator', (widgetTester) async {
      when(mockNowPlayingTvCubit.stream).thenAnswer(
        (_) => Stream.value(tNowPlayingLoading),
      );
      when(mockNowPlayingTvCubit.state).thenReturn(tNowPlayingLoading);
      when(mockPopularTvCubit.stream).thenAnswer(
        (_) => Stream.value(tPopularError),
      );
      when(mockPopularTvCubit.state).thenReturn(tPopularError);
      when(mockTopRatedTvCubit.stream).thenAnswer(
        (_) => Stream.value(tTopRatedError),
      );
      when(mockTopRatedTvCubit.state).thenReturn(tTopRatedError);

      final progressBar = find.byType(CircularProgressIndicator);

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvSeriesHomePage()));

      expect(progressBar, findsOneWidget);
    });

    testWidgets('page should display error', (widgetTester) async {
      when(mockNowPlayingTvCubit.stream).thenAnswer(
        (_) => Stream.value(tNowPlayingError),
      );
      when(mockNowPlayingTvCubit.state).thenReturn(tNowPlayingError);
      when(mockPopularTvCubit.stream).thenAnswer(
        (_) => Stream.value(tPopularLoaded),
      );
      when(mockPopularTvCubit.state).thenReturn(tPopularLoaded);
      when(mockTopRatedTvCubit.stream).thenAnswer(
        (_) => Stream.value(tTopRatedLoaded),
      );
      when(mockTopRatedTvCubit.state).thenReturn(tTopRatedLoaded);

      final textWidget = find.bySemanticsLabel('text_info_1');

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvSeriesHomePage()));

      expect(textWidget, findsOneWidget);
    });

    testWidgets('page should display list of data', (widgetTester) async {
      when(mockNowPlayingTvCubit.stream).thenAnswer(
        (_) => Stream.value(tNowPlayingLoaded),
      );
      when(mockNowPlayingTvCubit.state).thenReturn(tNowPlayingLoaded);
      when(mockPopularTvCubit.stream).thenAnswer(
        (_) => Stream.value(tPopularError),
      );
      when(mockPopularTvCubit.state).thenReturn(tPopularError);
      when(mockTopRatedTvCubit.stream).thenAnswer(
        (_) => Stream.value(tTopRatedError),
      );
      when(mockTopRatedTvCubit.state).thenReturn(tTopRatedError);

      final listView = find.byType(TvSeriesList);

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvSeriesHomePage()));

      expect(listView, findsOneWidget);
    });
  });

  group('popular', () {
    testWidgets('page should display loading indicator', (widgetTester) async {
      when(mockNowPlayingTvCubit.stream).thenAnswer(
        (_) => Stream.value(tNowPlayingError),
      );
      when(mockNowPlayingTvCubit.state).thenReturn(tNowPlayingError);
      when(mockPopularTvCubit.stream).thenAnswer(
        (_) => Stream.value(tPopularLoading),
      );
      when(mockPopularTvCubit.state).thenReturn(tPopularLoading);
      when(mockTopRatedTvCubit.stream).thenAnswer(
        (_) => Stream.value(tTopRatedError),
      );
      when(mockTopRatedTvCubit.state).thenReturn(tTopRatedError);

      final progressBar = find.byType(CircularProgressIndicator);

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvSeriesHomePage()));

      expect(progressBar, findsOneWidget);
    });

    testWidgets('page should display error', (widgetTester) async {
      when(mockNowPlayingTvCubit.stream).thenAnswer(
        (_) => Stream.value(tNowPlayingError),
      );
      when(mockNowPlayingTvCubit.state).thenReturn(tNowPlayingError);
      when(mockPopularTvCubit.stream).thenAnswer(
        (_) => Stream.value(tPopularError),
      );
      when(mockPopularTvCubit.state).thenReturn(tPopularError);
      when(mockTopRatedTvCubit.stream).thenAnswer(
        (_) => Stream.value(tTopRatedError),
      );
      when(mockTopRatedTvCubit.state).thenReturn(tTopRatedError);

      final textWidget = find.bySemanticsLabel('text_info_2');

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvSeriesHomePage()));

      expect(textWidget, findsOneWidget);
    });

    testWidgets('page should display list of data', (widgetTester) async {
      when(mockNowPlayingTvCubit.stream).thenAnswer(
        (_) => Stream.value(tNowPlayingError),
      );
      when(mockNowPlayingTvCubit.state).thenReturn(tNowPlayingError);
      when(mockPopularTvCubit.stream).thenAnswer(
        (_) => Stream.value(tPopularLoaded),
      );
      when(mockPopularTvCubit.state).thenReturn(tPopularLoaded);
      when(mockTopRatedTvCubit.stream).thenAnswer(
        (_) => Stream.value(tTopRatedError),
      );
      when(mockTopRatedTvCubit.state).thenReturn(tTopRatedError);

      final listView = find.byType(TvSeriesList);

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvSeriesHomePage()));

      expect(listView, findsOneWidget);
    });
  });

  group('top rated', () {
    testWidgets('page should display loading indicator', (widgetTester) async {
      when(mockNowPlayingTvCubit.stream).thenAnswer(
        (_) => Stream.value(tNowPlayingError),
      );
      when(mockNowPlayingTvCubit.state).thenReturn(tNowPlayingError);
      when(mockPopularTvCubit.stream).thenAnswer(
        (_) => Stream.value(tPopularError),
      );
      when(mockPopularTvCubit.state).thenReturn(tPopularError);
      when(mockTopRatedTvCubit.stream).thenAnswer(
        (_) => Stream.value(tTopRatedLoading),
      );
      when(mockTopRatedTvCubit.state).thenReturn(tTopRatedLoading);

      final progressBar = find.byType(CircularProgressIndicator);

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvSeriesHomePage()));

      expect(progressBar, findsOneWidget);
    });

    testWidgets('page should display error', (widgetTester) async {
      when(mockNowPlayingTvCubit.stream).thenAnswer(
        (_) => Stream.value(tNowPlayingError),
      );
      when(mockNowPlayingTvCubit.state).thenReturn(tNowPlayingError);
      when(mockPopularTvCubit.stream).thenAnswer(
        (_) => Stream.value(tPopularError),
      );
      when(mockPopularTvCubit.state).thenReturn(tPopularError);
      when(mockTopRatedTvCubit.stream).thenAnswer(
        (_) => Stream.value(tTopRatedError),
      );
      when(mockTopRatedTvCubit.state).thenReturn(tTopRatedError);

      final textWidget = find.bySemanticsLabel('text_info_3');

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvSeriesHomePage()));

      expect(textWidget, findsOneWidget);
    });

    testWidgets('page should display list of data', (widgetTester) async {
      when(mockNowPlayingTvCubit.stream).thenAnswer(
        (_) => Stream.value(tNowPlayingError),
      );
      when(mockNowPlayingTvCubit.state).thenReturn(tNowPlayingError);
      when(mockPopularTvCubit.stream).thenAnswer(
        (_) => Stream.value(tPopularError),
      );
      when(mockPopularTvCubit.state).thenReturn(tPopularError);
      when(mockTopRatedTvCubit.stream).thenAnswer(
        (_) => Stream.value(tTopRatedLoaded),
      );
      when(mockTopRatedTvCubit.state).thenReturn(tTopRatedLoaded);

      final listView = find.byType(TvSeriesList);

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvSeriesHomePage()));

      expect(listView, findsOneWidget);
    });
  });
}
