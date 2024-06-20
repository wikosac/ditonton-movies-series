
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/search.dart';
import '../../domain/usecases/search_usecase.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchUseCase searchUsecase;

  SearchNotifier(this.searchUsecase);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Search> _searchResult = [];

  List<Search> get searchResult => _searchResult;

  String _message = '';

  String get message => _message;

  Future<void> fetchSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchUsecase.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}