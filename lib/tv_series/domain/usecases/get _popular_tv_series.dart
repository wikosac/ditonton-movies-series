import 'package:ditonton/core/usecases/usecases.dart';
import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';

class GetPopularTvSeries extends UsecaseWithoutParams<List<TvSeries>> {
  GetPopularTvSeries(this.tvSeriesRepository);

  final TvSeriesRepository tvSeriesRepository;

  @override
  ResultFuture<List<TvSeries>> call() {
    return tvSeriesRepository.getNowPlayingTvSeries();
  }
}
