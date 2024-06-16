import 'package:ditonton/core/utils/state_enum.dart';
import 'package:ditonton/tv_series/domain/entities/episode.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tv_series_season.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesSeasonNotifier extends ChangeNotifier {
  TvSeriesSeasonNotifier(this.getTvSeriesSeason);

  final GetTvSeriesSeason getTvSeriesSeason;

  List<Episode> _episodes = [];
  RequestState _episodeState = RequestState.Loading;
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
