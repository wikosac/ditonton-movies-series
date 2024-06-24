part of 'top_rated_movies_cubit.dart';

sealed class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object?> get props => [];
}

final class TopRatedMoviesInitial extends TopRatedMoviesState {}

final class TopRatedMoviesLoading extends TopRatedMoviesState {}

final class TopRatedMoviesLoaded extends TopRatedMoviesState {
  const TopRatedMoviesLoaded(this.movies);

  final List<Movie> movies;

  @override
  List<Object?> get props => [movies];
}

final class TopRatedMoviesError extends TopRatedMoviesState {
  const TopRatedMoviesError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
