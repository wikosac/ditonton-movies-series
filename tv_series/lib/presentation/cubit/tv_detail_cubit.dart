import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  TvDetailCubit(
    this._getTvSeriesDetail,
    this._getTvSeriesRecommendations,
  ) : super(TvDetailInitial());

  final GetTvSeriesDetail _getTvSeriesDetail;
  final GetTvSeriesRecommendations _getTvSeriesRecommendations;

  void fetchTvSeriesDetail(int id) async {
    emit(TvDetailLoading());

    final detailResult = await _getTvSeriesDetail.call(id);
    final recommendationResult = await _getTvSeriesRecommendations.call(id);

    detailResult.fold((failure) async {
      emit(TvDetailError(failure.message));
    }, (detail) async {
      emit(TvSeriesRecommendationLoading());
      recommendationResult.fold(
        (failure) async {
          emit(TvSeriesRecommendationError(detail, const [], failure.message));
        },
        (recommendation) async {
          emit(TvDetailLoaded(detail, recommendation));
        },
      );
    });
  }
}
