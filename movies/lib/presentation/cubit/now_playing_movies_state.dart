part of 'now_playing_movies_cubit.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

final class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

final class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

final class NowPlayingMoviesLoaded extends NowPlayingMoviesState {
  const NowPlayingMoviesLoaded(this.movies);

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];
}

final class NowPlayingMoviesError extends NowPlayingMoviesState {
  const NowPlayingMoviesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
