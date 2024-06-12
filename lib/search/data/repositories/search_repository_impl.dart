import 'package:dartz/dartz.dart';
import 'package:ditonton/core/errors/exception.dart';
import 'package:ditonton/core/errors/failure.dart';
import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/search/data/sources/search_data_source.dart';
import 'package:ditonton/search/domain/entities/search.dart';
import 'package:ditonton/search/domain/repositories/search_repository.dart';

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
