import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'top_rated_tv_state.dart';

class TopRatedTvCubit extends Cubit<TopRatedTvState> {
  TopRatedTvCubit(this._getTopRatedTvSeries) : super(TopRatedTvInitial());

  final GetTopRatedTvSeries _getTopRatedTvSeries;

  void fetchOnTheAirTvSeries() async {
    emit(TopRatedTvSeriesLoading());
    final result = await _getTopRatedTvSeries.call();
    result.fold((failure) async {
      emit(TopRatedTvSeriesError(failure.message));
    }, (data) async {
      emit(TopRatedTvSeriesLoaded(data));
    });
  }
}
