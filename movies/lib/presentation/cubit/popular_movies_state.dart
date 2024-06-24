part of 'popular_movies_cubit.dart';

sealed class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object?> get props => [];
}

final class PopularMoviesInitial extends PopularMoviesState {}

final class PopularMoviesLoading extends PopularMoviesState {}

final class PopularMoviesLoaded extends PopularMoviesState {
  const PopularMoviesLoaded(this.movies);

  final List<Movie> movies;

  @override
  List<Object?> get props => [movies];
}

final class PopularMoviesError extends PopularMoviesState {
  const PopularMoviesError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
