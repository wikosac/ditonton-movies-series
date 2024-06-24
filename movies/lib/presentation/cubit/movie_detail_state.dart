part of 'movie_detail_cubit.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailLoaded extends MovieDetailState {
  const MovieDetailLoaded(this.movieDetail, this.recommendationsMovie);

  final MovieDetail movieDetail;
  final List<Movie> recommendationsMovie;

  @override
  List<Object> get props => [movieDetail, recommendationsMovie];
}

final class MovieDetailError extends MovieDetailState {
  const MovieDetailError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class MovieRecommendationsLoading extends MovieDetailState {}

final class MovieRecommendationsError extends MovieDetailState {
  const MovieRecommendationsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
