import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'popular_tv_state.dart';

class PopularTvCubit extends Cubit<PopularTvState> {
  PopularTvCubit(this._getPopularTvSeries) : super(PopularTvInitial());

  final GetPopularTvSeries _getPopularTvSeries;

  void fetchPopularTvSeries() async {
    emit(PopularTvLoading());
    final result = await _getPopularTvSeries.call();
    result.fold((failure) async {
      emit(PopularTvError(failure.message));
    }, (data) async {
      emit(PopularTvLoaded(data));
    });
  }
}
