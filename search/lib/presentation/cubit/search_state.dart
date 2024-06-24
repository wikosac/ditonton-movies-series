part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  const SearchLoaded(this.items);

  final List<Search> items;

  @override
  List<Object> get props => [items];
}

final class SearchError extends SearchState {
  const SearchError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
