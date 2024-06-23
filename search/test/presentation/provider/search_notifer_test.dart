import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_usecase.dart';
import 'package:search/presentation/provider/search_notifier.dart';

import '../../dummy/dummy_objects.dart';
import 'search_notifer_test.mocks.dart';

@GenerateMocks([SearchUseCase])
void main() {
  late MockSearchUseCase mockSearchUseCase;
  late SearchNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchUseCase = MockSearchUseCase();
    provider = SearchNotifier(mockSearchUseCase)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tSearchList = [testSearchEntity];
  final query = 'interstellar';

  test('return error state', () async {
    when(mockSearchUseCase.execute(query))
        .thenAnswer((_) async => Left(ServerFailure('Server error')));

    await provider.fetchSearch(query);

    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server error');
    expect(listenerCallCount, 2);
  });

  test('return loading state', () async {
    when(mockSearchUseCase.execute(query))
        .thenAnswer((_) async => Right(tSearchList));

    provider.fetchSearch(query);

    expect(provider.state, RequestState.Loading);
  });

  test('return loaded state', () async {
    when(mockSearchUseCase.execute(query))
        .thenAnswer((_) async => Right(tSearchList));

    await provider.fetchSearch(query);

    expect(provider.state, RequestState.Loaded);
    expect(provider.searchResult, tSearchList);
    expect(listenerCallCount, 2);
  });

}