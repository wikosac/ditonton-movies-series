import 'package:ditonton/core/utils/state_enum.dart';
import 'package:ditonton/search/presentation/pages/search_page.dart';
import 'package:ditonton/search/presentation/provider/search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy/dummy_objects.dart';
import 'search_page_test.mocks.dart';

@GenerateMocks([SearchNotifier])
void main() {
  late MockSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSearchNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SearchNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display loading indicator', (widgetTester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressBar = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(progressBar, findsOneWidget);
  });

  testWidgets('page should display error', (widgetTester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Server error');

    final textWidget = find.bySemanticsLabel('text_info');

    await widgetTester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(textWidget, findsOneWidget);
  });

  testWidgets('page should display list of data', (widgetTester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.searchResult).thenReturn([testSearchEntity]);

    final searchBar = find.byKey(Key('textField_search'));
    final listView = find.byType(ListView);

    await widgetTester.pumpWidget(_makeTestableWidget(SearchPage()));
    await widgetTester.enterText(searchBar, 'the flash');
    await widgetTester.testTextInput.receiveAction(TextInputAction.search);

    expect(listView, findsOneWidget);
  });
}
