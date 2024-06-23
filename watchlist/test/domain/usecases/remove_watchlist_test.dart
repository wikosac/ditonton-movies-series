import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockWatchlistRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistRepository();
    usecase = RemoveWatchlist(mockRepository);
  });

  final tFailure = DatabaseFailure('Internal error');
  final tRemoveMessage = WATCHLIST_REMOVE_MESSAGE;

  test('return either success remove message', () async {
    when(mockRepository.removeWatchlist(1))
        .thenAnswer((_) async => Right(tRemoveMessage));

    final result = await usecase.execute(1);

    expect(result, Right(tRemoveMessage));
    verify(usecase.execute(1)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('return either Failure', () async {
    when(mockRepository.removeWatchlist(1))
        .thenAnswer((_) async => Left(tFailure));

    final result = await usecase.execute(1);

    expect(result, Left(tFailure));
    verify(usecase.execute(1)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
