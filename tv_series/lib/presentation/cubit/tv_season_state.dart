part of 'tv_season_cubit.dart';

sealed class TvSeasonState extends Equatable {
  const TvSeasonState();

  @override
  List<Object> get props => [];
}

final class TvSeasonInitial extends TvSeasonState {}

final class TvSeasonLoading extends TvSeasonState {}

final class TvSeasonLoaded extends TvSeasonState {
  const TvSeasonLoaded(this.episodes);

  final List<Episode> episodes;

  @override
  List<Object> get props => [episodes];
}

final class TvSeasonError extends TvSeasonState {
  const TvSeasonError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
