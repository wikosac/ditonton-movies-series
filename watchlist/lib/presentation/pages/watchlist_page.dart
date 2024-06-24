import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  WatchlistPageState createState() => WatchlistPageState();
}

class WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistCubit>().fetchWatchlist(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistCubit>().fetchWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: BlocBuilder<WatchlistCubit, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistLoaded) {
            final items = state.watchlist;
            return items.isNotEmpty
                ? AlignedGridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final watchlist = items[index];
                      return InkWell(
                        onTap: () {
                          watchlist.mediaType == 'TV'
                              ? Navigator.pushNamed(
                                  context,
                                  TV_DETAIL_ROUTE,
                                  arguments: watchlist.id,
                                )
                              : Navigator.pushNamed(
                                  context,
                                  MOVIE_DETAIL_ROUTE,
                                  arguments: watchlist.id,
                                );
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          child: CachedNetworkImage(
                            imageUrl: '$BASE_IMAGE_URL${watchlist.posterPath}',
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('No data'),
                  );
          } else if (state is WatchlistError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
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
