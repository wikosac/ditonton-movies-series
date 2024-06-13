import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/search/domain/entities/search.dart';
import 'package:ditonton/search/domain/repositories/search_repository.dart';

class SearchUseCase {
  final SearchRepository searchRepository;

  SearchUseCase(this.searchRepository);

  ResultFuture<List<Search>> execute(String query) {
    return searchRepository.search(query);
  }
}
