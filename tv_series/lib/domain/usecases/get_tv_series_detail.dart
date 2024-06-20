import 'package:core/core.dart';

import '../entities/tv_series.dart';
import '../entities/tv_series_detail.dart';
import '../repositories/tv_series_repository.dart';

class GetTvSeriesDetail extends UsecaseWithParams<TvSeriesDetail, int> {
  GetTvSeriesDetail(this.tvSeriesRepository);

  final TvSeriesRepository tvSeriesRepository;

  @override
  ResultFuture<TvSeriesDetail> call(int id) {
    return tvSeriesRepository.getTvSeriesDetail(id);
  }
}
