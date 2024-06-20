import 'package:core/core.dart';

import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetTvSeriesRecommendations extends UsecaseWithParams<List<TvSeries>, int> {
  GetTvSeriesRecommendations(this.tvSeriesRepository);

  final TvSeriesRepository tvSeriesRepository;

  @override
  ResultFuture<List<TvSeries>> call(int id) {
    return tvSeriesRepository.getTvSeriesRecommendations(id);
  }
}