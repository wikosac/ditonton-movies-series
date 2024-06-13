import 'package:ditonton/core/usecases/usecases.dart';
import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';

class GetTvSeriesRecommendations extends UsecaseWithParams<List<TvSeries>, int> {
  GetTvSeriesRecommendations(this.tvSeriesRepository);

  final TvSeriesRepository tvSeriesRepository;

  @override
  ResultFuture<List<TvSeries>> call(int id) {
    return tvSeriesRepository.getTvSeriesRecommendations(id);
  }
}