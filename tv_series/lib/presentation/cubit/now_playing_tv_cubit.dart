import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'now_playing_tv_state.dart';

class NowPlayingTvCubit extends Cubit<NowPlayingTvState> {
  NowPlayingTvCubit(this._getNowPlayingTvSeries) : super(NowPlayingTvInitial());

  final GetNowPlayingTvSeries _getNowPlayingTvSeries;

  void fetchOnTheAirTvSeries() async {
    emit(NowPlayingTvSeriesLoading());
    final result = await _getNowPlayingTvSeries.call();
    result.fold((failure) async {
      emit(NowPlayingTvSeriesError(failure.message));
    }, (data) async {
      emit(NowPlayingTvSeriesLoaded(data));
    });
  }
}
