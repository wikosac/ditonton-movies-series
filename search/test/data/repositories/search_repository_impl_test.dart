import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/data/repositories/search_repository_impl.dart';
import 'package:search/domain/repositories/search_repository.dart';

import '../../dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchRepository repository;
  late MockSearchDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockSearchDataSource();
    repository = SearchRepositoryImpl(searchDataSource: mockDataSource);
  });

  final tSearchList = [testSearchEntity];
  final query = 'the flash';
  final tError = ServerException(message: 'Server error');

  test('return either List<Search> when success', () async {
    when(mockDataSource.search(query)).thenAnswer((_) async => tSearchList);

    final actual = await repository.search(query);

    expect(actual, Right(tSearchList));
    verify(mockDataSource.search(query)).called(1);
    verifyNoMoreInteractions(mockDataSource);
  });

  test('return either Failure when unsuccessful', () async {
    when(mockDataSource.search(query)).thenThrow(tError);

    final actual = await repository.search(query);

    expect(actual, Left(ServerFailure(tError.message)));
    verify(mockDataSource.search(query)).called(1);
    verifyNoMoreInteractions(mockDataSource);
  });
}
