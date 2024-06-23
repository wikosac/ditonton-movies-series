import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';


void main() {
  late GetWatchListStatus usecase;
  late MockWatchlistRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistRepository();
    usecase = GetWatchListStatus(mockRepository);
  });

  test('return isAdded status', () async {
    when(mockRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);

    final result = await usecase.execute(1);

    expect(result, true);
    verify(usecase.execute(1)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
