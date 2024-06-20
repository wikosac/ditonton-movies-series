import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/search.dart';
import '../../domain/repositories/search_repository.dart';
import '../sources/search_data_source.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl({required this.searchDataSource});

  final SearchDataSource searchDataSource;

  @override
  ResultFuture<List<Search>> search(String query) async {
    try {
      final result = await searchDataSource.search(query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
