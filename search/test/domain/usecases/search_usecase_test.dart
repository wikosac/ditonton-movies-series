import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_usecase.dart';

import '../../dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchUseCase usecase;
  late MockSearchRepository mockRepository;

  setUp(() {
    mockRepository = MockSearchRepository();
    usecase = SearchUseCase(mockRepository);
  });

  final tSearchList = [testSearchEntity];
  final query = 'the flash';

  test('return either List<Search>', () async {
    when(mockRepository.search(query))
        .thenAnswer((_) async => Right(tSearchList));

    final result = await usecase.execute(query);

    expect(result, Right(tSearchList));
    verify(usecase.execute(query)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
