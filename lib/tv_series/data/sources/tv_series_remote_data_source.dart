import 'package:ditonton/tv_series/data/models/tv_detail_response.dart';
import 'package:ditonton/tv_series/data/models/tv_response.dart';

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  @override
  Future<TvDetailResponse> getMovieDetail(int id) {
    // TODO: implement getMovieDetail
    throw UnimplementedError();
  }

  @override
  Future<TvResponse> getMovieRecommendations(int id) {
    // TODO: implement getMovieRecommendations
    throw UnimplementedError();
  }

  @override
  Future<TvResponse> getNowPlayingMovies() {
    // TODO: implement getNowPlayingMovies
    throw UnimplementedError();
  }

  @override
  Future<TvResponse> getPopularMovies() {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<TvResponse> getTopRatedMovies() {
    // TODO: implement getTopRatedMovies
    throw UnimplementedError();
  }

  @override
  Future<TvResponse> searchMovies(String query) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }
}

abstract class TvSeriesRemoteDataSource {
  Future<TvResponse> getNowPlayingMovies();

  Future<TvResponse> getPopularMovies();

  Future<TvResponse> getTopRatedMovies();

  Future<TvDetailResponse> getMovieDetail(int id);

  Future<TvResponse> getMovieRecommendations(int id);

  Future<TvResponse> searchMovies(String query);
}
