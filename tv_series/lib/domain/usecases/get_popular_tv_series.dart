import 'package:core/core.dart';

import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetPopularTvSeries extends UsecaseWithoutParams<List<TvSeries>> {
  GetPopularTvSeries(this.tvSeriesRepository);

  final TvSeriesRepository tvSeriesRepository;

  @override
  ResultFuture<List<TvSeries>> call() {
    return tvSeriesRepository.getPopularTvSeries();
  }
}
