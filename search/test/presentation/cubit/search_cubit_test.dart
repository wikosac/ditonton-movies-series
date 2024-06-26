import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../dummy/dummy_objects.dart';
import 'search_cubit_test.mocks.dart';

@GenerateMocks([SearchUseCase])
void main() {
  late MockSearchUseCase mockSearchUseCase;
  late SearchCubit searchCubit;

  setUp(() {
    mockSearchUseCase = MockSearchUseCase();
    searchCubit = SearchCubit(mockSearchUseCase);
  });

  const query = 'fallout';

  test('initial state should be initial', () {
    expect(searchCubit.state, SearchInitial());
  });

  blocTest<SearchCubit, SearchState>(
    'return loaded state when successful',
    build: () {
      when(mockSearchUseCase.execute(query))
          .thenAnswer((_) async => Right([testSearchEntity]));
      return searchCubit;
    },
    act: (cubit) => cubit.searchItems(query),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchLoaded([testSearchEntity]),
    ],
    verify: (bloc) {
      verify(mockSearchUseCase.execute(query));
    },
  );

  blocTest<SearchCubit, SearchState>(
    'return error state when unsuccessful',
    build: () {
      when(mockSearchUseCase.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Error')));
      return searchCubit;
    },
    act: (cubit) => cubit.searchItems(query),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Error'),
    ],
    verify: (bloc) {
      verify(mockSearchUseCase.execute(query));
    },
  );
}
