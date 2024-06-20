import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/episode.dart';
import '../../domain/usecases/get_tv_series_season.dart';

class TvSeriesSeasonNotifier extends ChangeNotifier {
  TvSeriesSeasonNotifier(this.getTvSeriesSeason);

  final GetTvSeriesSeason getTvSeriesSeason;

  List<Episode> _episodes = [];
  RequestState _episodeState = RequestState.Empty;
  String _message = '';

  Future<void> fetchTvSeriesSeason(int id, int seasonNumber) async {
    _episodeState = RequestState.Loading;
    notifyListeners();
    final seasonResult = await getTvSeriesSeason.call(id, seasonNumber);
    seasonResult.fold(
      (failure) {
        _episodeState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (episodesData) {
        _episodeState = RequestState.Loaded;
        _episodes = episodesData;
        notifyListeners();
      },
    );
  }

  List<Episode> get episodes => _episodes;

  RequestState get episodeState => _episodeState;

  String get message => _message;
}
