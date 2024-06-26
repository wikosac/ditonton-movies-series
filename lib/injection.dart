import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

final locator = GetIt.instance;

void init(HttpClient httpClient) {
  // provider
  locator.registerFactory(
    () => MovieDetailCubit(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailCubit(
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesCubit(locator()),
  );
  locator.registerFactory(
    () => PopularMoviesCubit(locator()),
  );
  locator.registerFactory(
    () => TopRatedMoviesCubit(locator()),
  );
  locator.registerFactory(
    () => NowPlayingTvCubit(locator()),
  );
  locator.registerFactory(
    () => PopularTvCubit(locator()),
  );
  locator.registerFactory(
    () => TopRatedTvCubit(locator()),
  );
  locator.registerFactory(
    () => TvSeasonCubit(locator()),
  );
  locator.registerFactory(
    () => SearchCubit(locator()),
  );
  locator.registerFactory(() => WatchlistCubit(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // use case
  locator.registerLazySingleton(
    () => GetNowPlayingMovies(locator()),
  );
  locator.registerLazySingleton(
    () => GetPopularMovies(locator()),
  );
  locator.registerLazySingleton(
    () => GetTopRatedMovies(locator()),
  );
  locator.registerLazySingleton(
    () => GetMovieDetail(locator()),
  );
  locator.registerLazySingleton(
    () => GetMovieRecommendations(locator()),
  );
  locator.registerLazySingleton(
    () => GetNowPlayingTvSeries(locator()),
  );
  locator.registerLazySingleton(
    () => GetPopularTvSeries(locator()),
  );
  locator.registerLazySingleton(
    () => GetTopRatedTvSeries(locator()),
  );
  locator.registerLazySingleton(
    () => GetTvSeriesDetail(locator()),
  );
  locator.registerLazySingleton(
    () => GetTvSeriesRecommendations(locator()),
  );
  locator.registerLazySingleton(
    () => GetTvSeriesSeason(locator()),
  );
  locator.registerLazySingleton(
    () => SearchUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => GetWatchListStatus(locator()),
  );
  locator.registerLazySingleton(
    () => SaveWatchlist(locator()),
  );
  locator.registerLazySingleton(
    () => RemoveWatchlist(locator()),
  );
  locator.registerLazySingleton(
    () => GetWatchlist(locator()),
  );

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(searchDataSource: locator()),
  );
  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(watchlistDataSource: locator()),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(tvSeriesRemoteDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<WatchlistDataSource>(
    () => WatchlistDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<SearchDataSource>(
    () => SearchDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(client: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper(),
  );

  // external
  locator.registerLazySingleton(
    () => IOClient(httpClient),
  );
}
