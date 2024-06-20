import 'package:core/core.dart';

import '../entities/search.dart';

abstract class SearchRepository {
  ResultFuture<List<Search>> search(String query);
}
