import 'package:ditonton/core/usecases/usecases.dart';
import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';

class GetTvSeriesDetail extends UsecaseWithParams<TvSeriesDetail, int> {
  GetTvSeriesDetail(this.tvSeriesRepository);

  final TvSeriesRepository tvSeriesRepository;

  @override
  ResultFuture<TvSeriesDetail> call(int id) {
    return tvSeriesRepository.getTvSeriesDetail(id);
  }
}
