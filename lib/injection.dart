import 'package:ditonton/movies/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/movies/data/sources/movie_remote_data_source.dart';
import 'package:ditonton/movies/domain/repositories/movie_repository.dart';
import 'package:ditonton/movies/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/movies/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/movies/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/movies/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/movies/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/movies/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/search/data/repositories/search_repository_impl.dart';
import 'package:ditonton/search/data/sources/search_data_source.dart';
import 'package:ditonton/search/domain/repositories/search_repository.dart';
import 'package:ditonton/search/domain/usecases/search_usecase.dart';
import 'package:ditonton/search/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/tv_series/data/sources/tv_series_remote_data_source.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/tv_series/domain/usecases/get%20_popular_tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/tv_series/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/tv_series/presentation/provider/tv_series_list_provider.dart';
import 'package:ditonton/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:ditonton/watchlist/data/sources/database_helper.dart';
import 'package:ditonton/watchlist/data/sources/watchlist_data_source.dart';
import 'package:ditonton/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:ditonton/watchlist/domain/usecases/get_watchlist.dart';
import 'package:ditonton/watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/watchlist/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/watchlist/domain/usecases/save_watchlist.dart';
import 'package:ditonton/watchlist/presentation/provider/watchlist_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
        () => TvSeriesListProvider(
      getNowPlayingTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailNotifier(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchNotifier(
      searchUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistNotifier(
      getWatchlistMovies: locator(),
    ),
  );

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
