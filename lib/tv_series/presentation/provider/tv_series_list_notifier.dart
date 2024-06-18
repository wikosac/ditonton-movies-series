import 'package:ditonton/core/utils/state_enum.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  TvSeriesListNotifier({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  });

  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  var _nowPlayingTvSeries = <TvSeries>[];
  RequestState _nowPlayingState = RequestState.Empty;
  var _popularTvSeries = <TvSeries>[];
  RequestState _popularTvSeriesState = RequestState.Empty;
  var _topRatedTvSeries = <TvSeries>[];
  RequestState _topRatedTvSeriesState = RequestState.Empty;
  String _message = '';

  List<TvSeries> get nowPlayingTvSeries => _nowPlayingTvSeries;

  RequestState get nowPlayingState => _nowPlayingState;

  List<TvSeries> get popularTvSeries => _popularTvSeries;

  RequestState get popularTvSeriesState => _popularTvSeriesState;

  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;

  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;

  String get message => _message;

  Future<void> fetchNowPlayingTvSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.call();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.call();
    result.fold(
      (failure) {
        _popularTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularTvSeriesState = RequestState.Loaded;
        _popularTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.call();
    result.fold(
      (failure) {
        _topRatedTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedTvSeriesState = RequestState.Loaded;
        _topRatedTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
