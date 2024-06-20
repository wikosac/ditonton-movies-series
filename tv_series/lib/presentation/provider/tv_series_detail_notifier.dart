import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/watchlist.dart';

import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';
import '../../domain/usecases/get_tv_series_detail.dart';
import '../../domain/usecases/get_tv_series_recommendations.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  late TvSeriesDetail _series;
  RequestState _detailState = RequestState.Empty;
  List<TvSeries> _seriesRecommendations = [];
  RequestState _recommendationState = RequestState.Empty;
  String _message = '';
  bool _isWatchlist = false;
  String _watchlistMessage = '';

  TvSeriesDetail get series => _series;

  RequestState get detailState => _detailState;

  List<TvSeries> get seriesRecommendations => _seriesRecommendations;

  RequestState get recommendationState => _recommendationState;

  String get message => _message;

  bool get isWatchlist => _isWatchlist;

  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTvSeriesDetail(int id) async {
    _detailState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.call(id);
    final recommendationResult = await getTvSeriesRecommendations.call(id);
    detailResult.fold(
      (failure) {
        _detailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (series) {
        _recommendationState = RequestState.Loading;
        _series = series;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (rec) {
            _recommendationState = RequestState.Loaded;
            _seriesRecommendations = rec;
          },
        );
        _detailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isWatchlist = result;
    notifyListeners();
  }

  Future<void> addWatchlist(TvSeriesDetail series) async {
    final result = await saveWatchlist.execute(series.toWatchlist());

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail series) async {
    final result = await removeWatchlist.execute(series.id);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }
}
