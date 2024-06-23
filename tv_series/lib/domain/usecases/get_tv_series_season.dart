import 'package:core/core.dart';

import '../entities/episode.dart';
import '../repositories/tv_series_repository.dart';

class GetTvSeriesSeason {
  GetTvSeriesSeason(this.tvSeriesRepository);

  final TvSeriesRepository tvSeriesRepository;

  ResultFuture<List<Episode>> call(int id, int seasonNumber) {
    return tvSeriesRepository.getTvSeriesSeason(id, seasonNumber);
  }
}
