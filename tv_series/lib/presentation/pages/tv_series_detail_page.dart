import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';
import '../provider/tv_series_detail_notifier.dart';
import '../widgets/episode_card_list.dart';

class TvSeriesDetailPage extends StatefulWidget {
  TvSeriesDetailPage({required this.id});

  final int id;

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .fetchTvSeriesDetail(widget.id);
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.detailState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.detailState == RequestState.Loaded) {
            final movie = provider.series;
            return SafeArea(
              child: DetailContent(
                movie,
                provider.seriesRecommendations,
                provider.isWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TvSeriesDetail series;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.series, this.recommendations, this.isAddedWatchlist);

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
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
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
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.series.rating / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '${widget.series.rating}',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              widget.series.overview,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  await Provider.of<TvSeriesDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlist(widget.series);
                                } else {
                                  await Provider.of<TvSeriesDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(widget.series);
                                }

                                final message =
                                    Provider.of<TvSeriesDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message == WATCHLIST_ADD_MESSAGE ||
                                    message == WATCHLIST_REMOVE_MESSAGE) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(message),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  SizedBox(width: 4),
                                  Text(
                                    widget.isAddedWatchlist
                                        ? 'Added'
                                        : 'Watchlist',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
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
                            SizedBox(height: 16),
                            Text(
                              'More Like This',
                              style: kHeading6,
                            ),
                            Consumer<TvSeriesDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.Loaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie =
                                            widget.recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TV_DETAIL_ROUTE,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            SizedBox(height: 16),
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
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
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
