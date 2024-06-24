part of 'top_rated_tv_cubit.dart';

sealed class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

final class TopRatedTvInitial extends TopRatedTvState {}

final class TopRatedTvLoading extends TopRatedTvState {}

final class TopRatedTvLoaded extends TopRatedTvState {
  const TopRatedTvLoaded(this.series);

  final List<TvSeries> series;

  @override
  List<Object> get props => [series];
}

final class TopRatedTvError extends TopRatedTvState {
  const TopRatedTvError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
