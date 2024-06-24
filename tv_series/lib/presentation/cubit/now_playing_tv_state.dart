part of 'now_playing_tv_cubit.dart';

sealed class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

final class NowPlayingTvInitial extends NowPlayingTvState {}

final class NowPlayingTvSeriesLoading extends NowPlayingTvState {}

final class NowPlayingTvSeriesLoaded extends NowPlayingTvState {
  const NowPlayingTvSeriesLoaded(this.series);

  final List<TvSeries> series;

  @override
  List<Object> get props => [series];
}

final class NowPlayingTvSeriesError extends NowPlayingTvState {
  const NowPlayingTvSeriesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
