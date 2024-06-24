part of 'tv_detail_cubit.dart';

sealed class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

final class TvDetailInitial extends TvDetailState {}

final class TvDetailLoading extends TvDetailState {}

final class TvDetailLoaded extends TvDetailState {
  const TvDetailLoaded(this.tvDetail, this.recommendationsTvSeries);

  final TvSeriesDetail tvDetail;
  final List<TvSeries> recommendationsTvSeries;

  @override
  List<Object> get props => [tvDetail, recommendationsTvSeries];
}

final class TvDetailError extends TvDetailState {
  const TvDetailError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class TvSeriesRecommendationLoading extends TvDetailState {}

final class TvSeriesRecommendationError extends TvDetailState {
  const TvSeriesRecommendationError(
    this.tvDetail,
    this.recommendationsTvSeries,
    this.message,
  );

  final TvSeriesDetail tvDetail;
  final List<TvSeries> recommendationsTvSeries;
  final String message;

  @override
  List<Object> get props => [tvDetail, recommendationsTvSeries, message];
}
