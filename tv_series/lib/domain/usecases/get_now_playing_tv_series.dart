
import 'package:core/core.dart';

import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetNowPlayingTvSeries extends UsecaseWithoutParams<List<TvSeries>> {
  GetNowPlayingTvSeries(this.tvSeriesRepository);

  final TvSeriesRepository tvSeriesRepository;

  @override
  ResultFuture<List<TvSeries>> call() {
    return tvSeriesRepository.getNowPlayingTvSeries();
  }
}
