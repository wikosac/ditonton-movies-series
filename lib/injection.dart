import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies.dart';
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
        () =>
        MovieListNotifier(
          getNowPlayingMovies: locator(),
          getPopularMovies: locator(),
          getTopRatedMovies: locator(),
        ),
  );
  locator.registerFactory(
        () =>
        MovieDetailNotifier(
          getMovieDetail: locator(),
          getMovieRecommendations: locator(),
          getWatchListStatus: locator(),
          saveWatchlist: locator(),
          removeWatchlist: locator(),
        ),
  );
  locator.registerFactory(
        () =>
        TvSeriesListNotifier(
          getNowPlayingTvSeries: locator(),
          getPopularTvSeries: locator(),
          getTopRatedTvSeries: locator(),
        ),
  );
  locator.registerFactory(
        () =>
        TvSeriesDetailNotifier(
          getTvSeriesDetail: locator(),
          getTvSeriesRecommendations: locator(),
          getWatchListStatus: locator(),
          saveWatchlist: locator(),
          removeWatchlist: locator(),
        ),
  );
  locator.registerFactory(() => NowPlayingMoviesNotifier(locator()));
  locator.registerFactory(() => PopularMoviesNotifier(locator()));
  locator.registerFactory(() => TopRatedMoviesNotifier(locator()));
  locator.registerFactory(() => NowPlayingTvSeriesNotifier(locator()));
  locator.registerFactory(() => PopularTvSeriesNotifier(locator()));
  locator.registerFactory(() => TopRatedTvSeriesNotifier(locator()));
  locator.registerFactory(() => TvSeriesSeasonNotifier(locator()));
  locator.registerFactory(() => SearchNotifier(locator()));
  locator.registerFactory(() => WatchlistNotifier(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvSeriesSeason(locator()));
  locator.registerLazySingleton(() => SearchUseCase(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));

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
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
