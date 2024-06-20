
import 'package:core/utils/typedef.dart';

import '../entities/search.dart';
import '../repositories/search_repository.dart';

class SearchUseCase {
  final SearchRepository searchRepository;

  SearchUseCase(this.searchRepository);

  ResultFuture<List<Search>> execute(String query) {
    return searchRepository.search(query);
  }
}
