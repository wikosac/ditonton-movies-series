import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/tv_series/domain/entities/episode.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';

class GetTvSeriesSeason {
  GetTvSeriesSeason(this.tvSeriesRepository);

  final TvSeriesRepository tvSeriesRepository;

  ResultFuture<List<Episode>> call(int id, int seasonNumber) {
    return tvSeriesRepository.getTvSeriesSeason(id, seasonNumber);
  }
}
