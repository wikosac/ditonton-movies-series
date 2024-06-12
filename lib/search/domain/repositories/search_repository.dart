import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/search/domain/entities/search.dart';

abstract class SearchRepository {
  ResultFuture<List<Search>> search(String query);
}
