import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

import '../widgets/episode_card_list.dart';

class TvSeriesDetailPage extends StatefulWidget {
  const TvSeriesDetailPage({super.key, required this.id});

  final int id;

  @override
  TvSeriesDetailPageState createState() => TvSeriesDetailPageState();
}

class TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TvDetailCubit>().fetchTvSeriesDetail(widget.id);
      context.read<WatchlistCubit>().checkWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailCubit, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailLoaded) {
            return SafeArea(
              child: DetailContent(state.tvDetail),
            );
          } else if (state is TvDetailError) {
            return Text(state.message);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TvSeriesDetail series;

  const DetailContent(this.series, {super.key});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: widget.series.seasons.length,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${widget.series.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.series.title,
                              style: kHeading5,
                            ),
                            Text(
                              _showGenres(widget.series.genres),
                              style: const TextStyle(fontSize: 10),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.series.rating / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.series.rating}',
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.series.overview,
                            ),
                            const SizedBox(height: 16),
                            _buildWatchlistButton(),
                            const SizedBox(height: 16),
                            TabBar(
                              controller: tabController,
                              isScrollable: true,
                              indicatorColor: kMikadoYellow,
                              labelPadding: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              tabs: widget.series.seasons
                                  .map((season) => Text(season.name))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 300,
                              child: TabBarView(
                                controller: tabController,
                                children: widget.series.seasons
                                    .map(
                                      (season) => EpisodeCardList(
                                        id: widget.series.id,
                                        seasonNumber: season.seasonNumber,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'More Like This',
                              style: kHeading6,
                            ),
                            _buildRecommendations(),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  BlocBuilder<TvDetailCubit, TvDetailState> _buildRecommendations() {
    return BlocBuilder<TvDetailCubit, TvDetailState>(
      builder: (context, state) {
        if (state is TvDetailRecommendationsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvDetailRecommendationsError) {
          return Text(state.message);
        } else if (state is TvDetailLoaded) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final series = state.recommendationsTvSeries[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        TV_DETAIL_ROUTE,
                        arguments: series.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${series.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.recommendationsTvSeries.length,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  BlocConsumer<WatchlistCubit, WatchlistState> _buildWatchlistButton() {
    return BlocConsumer<WatchlistCubit, WatchlistState>(
      listenWhen: (_, state) =>
          state is WatchlistSuccess || state is WatchlistError,
      listener: (context, state) {
        if (state is WatchlistSuccess) {
          final message = state.message;

          if (message == WATCHLIST_ADD_MESSAGE ||
              message == WATCHLIST_REMOVE_MESSAGE) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(message),
                  );
                });
          }
        }
      },
      builder: (context, state) {
        final cubit = context.read<WatchlistCubit>();
        return state is WatchlistStatus
            ? ElevatedButton(
                onPressed: () async {
                  if (!state.isWatchlist) {
                    cubit.addWatchlist(widget.series.toWatchlist());
                  } else {
                    cubit.removeWatchlist(widget.series.id);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    state.isWatchlist
                        ? const Icon(Icons.check)
                        : const Icon(Icons.add),
                    const SizedBox(width: 4),
                    Text(
                      state.isWatchlist ? 'Added' : 'Watchlist',
                    ),
                  ],
                ),
              )
            : const ElevatedButton(
                onPressed: null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    Text('Watchlist'),
                  ],
                ),
              );
      },
    );
  }

  String _showGenres(List<String> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre + ' | ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 3);
  }
}
