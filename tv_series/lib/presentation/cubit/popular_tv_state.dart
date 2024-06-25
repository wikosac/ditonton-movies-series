part of 'popular_tv_cubit.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

final class PopularTvInitial extends PopularTvState {}

final class PopularTvLoading extends PopularTvState {}

final class PopularTvLoaded extends PopularTvState {
  const PopularTvLoaded(this.series);

  final List<TvSeries> series;

  @override
  List<Object> get props => [series];
}

final class PopularTvError extends PopularTvState {
  const PopularTvError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
