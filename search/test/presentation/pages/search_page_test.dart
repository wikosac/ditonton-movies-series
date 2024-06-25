import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/cubit/search_cubit.dart';
import 'package:search/presentation/pages/search_page.dart';

import '../../dummy/dummy_objects.dart';
import 'search_page_test.mocks.dart';

@GenerateMocks([SearchCubit])
void main() {
  late MockSearchCubit mockCubit;

  setUp(() {
    mockCubit = MockSearchCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tLoading = SearchLoading();
  final tLoaded = SearchLoaded([testSearchEntity]);
  const tError = SearchError('Server error');

  testWidgets('page should display loading indicator', (widgetTester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tLoading),
    );
    when(mockCubit.state).thenReturn(tLoading);

    final progressBar = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(progressBar, findsOneWidget);
  });

  testWidgets('page should display error', (widgetTester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tError),
    );
    when(mockCubit.state).thenReturn(tError);

    final textWidget = find.bySemanticsLabel('text_info');

    await widgetTester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(textWidget, findsOneWidget);
  });

  testWidgets('page should display list of data', (widgetTester) async {
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(tLoaded),
    );
    when(mockCubit.state).thenReturn(tLoaded);

    final searchBar = find.byKey(const Key('textField_search'));
    final listView = find.byType(ListView);

    await widgetTester.pumpWidget(makeTestableWidget(const SearchPage()));
    await widgetTester.enterText(searchBar, 'the flash');
    await widgetTester.testTextInput.receiveAction(TextInputAction.search);

    expect(listView, findsOneWidget);
  });
}
