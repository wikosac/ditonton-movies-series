import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';

import '../../dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockWatchlistRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistRepository();
    usecase = SaveWatchlist(mockRepository);
  });

  final tWatchlist = dummyWatchlist;
  final tFailure = DatabaseFailure('Internal error');
  final tRemoveMessage = WATCHLIST_REMOVE_MESSAGE;

  test('return either success add message', () async {
    when(mockRepository.saveWatchlist(tWatchlist))
        .thenAnswer((_) async => Right(tRemoveMessage));

    final result = await usecase.execute(tWatchlist);

    expect(result, Right(tRemoveMessage));
    verify(usecase.execute(tWatchlist)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('return either Failure', () async {
    when(mockRepository.saveWatchlist(tWatchlist))
        .thenAnswer((_) async => Left(tFailure));

    final result = await usecase.execute(tWatchlist);

    expect(result, Left(tFailure));
    verify(usecase.execute(tWatchlist)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
