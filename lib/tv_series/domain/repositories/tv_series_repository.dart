import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  ResultFuture<List<TvSeries>> getNowPlayingTvSeries();

  ResultFuture<List<TvSeries>> getPopularTvSeries();

  ResultFuture<List<TvSeries>> getTopRatedTvSeries();

  ResultFuture<TvSeriesDetail> getTvSeriesDetail(int id);

  ResultFuture<List<TvSeries>> getTvSeriesRecommendations(int id);

  ResultFuture<List<TvSeries>> searchTvSeries(String query);

  ResultFuture<String> saveWatchlist(TvSeriesDetail movie);

  ResultFuture<String> removeWatchlist(TvSeriesDetail movie);

  Future<bool> isAddedToWatchlist(int id);

  ResultFuture<List<TvSeries>> getWatchlistTvSeries();
}