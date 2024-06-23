import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist.dart';

import '../../dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlist usecase;
  late MockWatchlistRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistRepository();
    usecase = GetWatchlist(mockRepository);
  });

  final tWatchlist = [dummyWatchlist];
  final tFailure = DatabaseFailure('Internal error');

  test('return either List<Watchlist>', () async {
    when(mockRepository.getWatchlist())
        .thenAnswer((_) async => Right(tWatchlist));

    final result = await usecase.execute();

    expect(result, Right(tWatchlist));
    verify(usecase.execute()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('return either Failure', () async {
    when(mockRepository.getWatchlist()).thenAnswer((_) async => Left(tFailure));

    final result = await usecase.execute();

    expect(result, Left(tFailure));
    verify(usecase.execute()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
