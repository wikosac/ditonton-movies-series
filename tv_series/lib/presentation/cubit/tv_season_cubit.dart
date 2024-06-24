import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_season_state.dart';

class TvSeasonCubit extends Cubit<TvSeasonState> {
  TvSeasonCubit(this._getTvSeriesSeason) : super(TvSeasonInitial());

  final GetTvSeriesSeason _getTvSeriesSeason;

  void fetchEpisodeTv(int id, int seasonNumber) async {
    emit(TvSeasonLoading());

    final result = await _getTvSeriesSeason.call(id, seasonNumber);
    result.fold(
      (failure) async {
        emit(TvSeasonError(failure.message));
      },
      (data) async {
        if (data.isNotEmpty) {
          emit(TvSeasonLoaded(data));
        } else {
          if (data.isEmpty) {
            emit(TvSeasonInitial());
          }
        }
      },
    );
  }
}
