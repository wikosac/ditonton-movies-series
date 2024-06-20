import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/tv_series_season_notifier.dart';

class EpisodeCardList extends StatefulWidget {
  final int id;
  final int seasonNumber;

  const EpisodeCardList({
    super.key,
    required this.id,
    required this.seasonNumber,
  });

  @override
  State<EpisodeCardList> createState() => _EpisodeCardListState();
}

class _EpisodeCardListState extends State<EpisodeCardList>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvSeriesSeasonNotifier>(context, listen: false)
          .fetchTvSeriesSeason(widget.id, widget.seasonNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TvSeriesSeasonNotifier>(
      builder: (context, provider, child) {
        if (provider.episodeState == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.episodeState == RequestState.Loaded) {
          return provider.episodes.isNotEmpty
              ? ListView.builder(
                  itemCount: provider.episodes.length,
                  itemBuilder: (context, index) {
                    final episode = provider.episodes[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: episode.stillPath == null
                                ? const SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Icon(Icons.error),
                                  )
                                : CachedNetworkImage(
                                    imageUrl:
                                        '$BASE_IMAGE_URL${episode.stillPath}',
                                    width: 100,
                                    height: 100,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  episode.title,
                                  style: kHeading6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'S${episode.seasonNumber} E${episode.episodeNumber} - ${convertDate(episode.airDate)} - ${episode.runtime ?? 0}m',
                                  style: kBodyText.copyWith(
                                      color: Colors.grey, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(child: Text('No data'));
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }

  String convertDate(String? date) {
    if (date != null) {
      DateTime parsedDate = DateTime.parse(date);
      DateFormat formatter = DateFormat('d MMM y');
      return formatter.format(parsedDate);
    } else {
      return '_';
    }
  }
}
