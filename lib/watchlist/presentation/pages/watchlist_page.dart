import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/core/utils/constants.dart';
import 'package:ditonton/core/utils/state_enum.dart';
import 'package:ditonton/core/utils/utils.dart';
import 'package:ditonton/movies/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/search/data/models/search_response.dart';
import 'package:ditonton/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/watchlist/presentation/provider/watchlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistNotifier>(context, listen: false)
            .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Consumer<WatchlistNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            return AlignedGridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: data.watchlist.length,
              itemBuilder: (context, index) {
                final watchlist = data.watchlist[index];
                print('Media: ' + watchlist.mediaType);
                return InkWell(
                  onTap: () {
                    watchlist.mediaType == MediaType.MOVIE.name
                        ? Navigator.pushNamed(
                            context,
                            MovieDetailPage.ROUTE_NAME,
                            arguments: watchlist.id,
                          )
                        : Navigator.pushNamed(
                            context,
                            TvSeriesDetailPage.ROUTE_NAME,
                            arguments: watchlist.id,
                          );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: CachedNetworkImage(
                      imageUrl: '$BASE_IMAGE_URL${watchlist.posterPath}',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
