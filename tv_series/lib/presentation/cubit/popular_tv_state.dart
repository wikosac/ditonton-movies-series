part of 'popular_tv_cubit.dart';

sealed class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

final class PopularTvInitial extends PopularTvState {}

final class PopularTvSeriesLoading extends PopularTvState {}

final class PopularTvSeriesLoaded extends PopularTvState {
  const PopularTvSeriesLoaded(this.series);

  final List<TvSeries> series;

  @override
  List<Object> get props => [series];
}

final class PopularTvSeriesError extends PopularTvState {
  const PopularTvSeriesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
