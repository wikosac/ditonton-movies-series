part of 'now_playing_tv_cubit.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

final class NowPlayingTvInitial extends NowPlayingTvState {}

final class NowPlayingTvLoading extends NowPlayingTvState {}

final class NowPlayingTvLoaded extends NowPlayingTvState {
  const NowPlayingTvLoaded(this.series);

  final List<TvSeries> series;

  @override
  List<Object> get props => [series];
}

final class NowPlayingTvError extends NowPlayingTvState {
  const NowPlayingTvError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
