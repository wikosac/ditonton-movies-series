import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
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

  @override
  ResultFuture<List<TvSeries>> getWatchlistTvSeries() {
    // TODO: implement getWatchlistTvSeries
    throw UnimplementedError();
  }

  @override
  Future<bool> isAddedToWatchlist(int id) {
    // TODO: implement isAddedToWatchlist
    throw UnimplementedError();
  }

  @override
  ResultFuture<String> removeWatchlist(TvSeriesDetail movie) {
    // TODO: implement removeWatchlist
    throw UnimplementedError();
  }

  @override
  ResultFuture<String> saveWatchlist(TvSeriesDetail movie) {
    // TODO: implement saveWatchlist
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<TvSeries>> searchTvSeries(String query) {
    // TODO: implement searchTvSeries
    throw UnimplementedError();
  }
  
}