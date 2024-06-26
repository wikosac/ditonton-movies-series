import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchUseCase) : super(SearchInitial());

  final SearchUseCase _searchUseCase;

  void searchItems(String query) async {
    emit(SearchLoading());
    final result = await _searchUseCase.execute(query);
    result.fold((failure) async {
      emit(SearchError(failure.message));
    }, (data) async {
      emit(SearchLoaded(data));
    });
  }
}
