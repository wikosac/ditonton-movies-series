part of 'top_rated_tv_cubit.dart';

sealed class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

final class TopRatedTvInitial extends TopRatedTvState {}

final class TopRatedTvSeriesLoading extends TopRatedTvState {}

final class TopRatedTvSeriesLoaded extends TopRatedTvState {
  const TopRatedTvSeriesLoaded(this.series);

  final List<TvSeries> series;

  @override
  List<Object> get props => [series];
}

final class TopRatedTvSeriesError extends TopRatedTvState {
  const TopRatedTvSeriesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
