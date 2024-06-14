import 'package:ditonton/core/usecases/usecases.dart';
import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';

class GetNowPlayingTvSeries extends UsecaseWithoutParams<List<TvSeries>> {
  GetNowPlayingTvSeries(this.tvSeriesRepository);

  final TvSeriesRepository tvSeriesRepository;

  @override
  ResultFuture<List<TvSeries>> call() {
    return tvSeriesRepository.getNowPlayingTvSeries();
  }
}
