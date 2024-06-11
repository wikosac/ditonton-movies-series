import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/tv_series/data/sources/tv_series_remote_data_source.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  TvSeriesRepositoryImpl({required this.tvSeriesRemoteDataSource});

  final TvSeriesRemoteDataSource tvSeriesRemoteDataSource;

  @override
  ResultFuture<List<TvSeries>> getNowPlayingTvSeries() {
    // TODO: implement getNowPlayingTvSeries
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<TvSeries>> getPopularTvSeries() {
    // TODO: implement getPopularTvSeries
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<TvSeries>> getTopRatedTvSeries() {
    // TODO: implement getTopRatedTvSeries
    throw UnimplementedError();
  }

  @override
  ResultFuture<TvSeriesDetail> getTvSeriesDetail(int id) {
    // TODO: implement getTvSeriesDetail
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<TvSeries>> getTvSeriesRecommendations(int id) {
    // TODO: implement getTvSeriesRecommendations
    throw UnimplementedError();
  }
}
