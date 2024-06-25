import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class TvSeriesHomePage extends StatefulWidget {
  const TvSeriesHomePage({super.key});

  @override
  State<TvSeriesHomePage> createState() => _TvSeriesHomePageState();
}

class _TvSeriesHomePageState extends State<TvSeriesHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvCubit>().fetchNowPlayingTvSeries();
      context.read<PopularTvCubit>().fetchPopularTvSeries();
      context.read<TopRatedTvCubit>().fetchTopRatedTvSeries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'On The Air',
              onTap: () => Navigator.pushNamed(context, NOW_PLAYING_TV_ROUTE),
            ),
            BlocBuilder<NowPlayingTvCubit, NowPlayingTvState>(
                builder: (context, state) {
              if (state is NowPlayingTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingTvLoaded) {
                return TvSeriesList(state.series);
              } else if (state is NowPlayingTvError) {
                return Text(
                  state.message,
                  semanticsLabel: 'text_info_1',
                );
              } else {
                return const SizedBox();
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, POPULAR_TV_ROUTE),
            ),
            BlocBuilder<PopularTvCubit, PopularTvState>(
                builder: (context, state) {
              if (state is PopularTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularTvLoaded) {
                return TvSeriesList(state.series);
              } else if (state is PopularTvError) {
                return Text(
                  state.message,
                  semanticsLabel: 'text_info_2',
                );
              } else {
                return const SizedBox();
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
            ),
            BlocBuilder<TopRatedTvCubit, TopRatedTvState>(
                builder: (context, state) {
              if (state is TopRatedTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedTvLoaded) {
                return TvSeriesList(state.series);
              } else if (state is TopRatedTvError) {
                return Text(
                  state.message,
                  semanticsLabel: 'text_info_3',
                );
              } else {
                return const SizedBox();
              }
            }),
            const SizedBox(height: 84),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> series;

  const TvSeriesList(this.series, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = series[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_DETAIL_ROUTE,
                  arguments: data.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: data.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: '$BASE_IMAGE_URL${data.posterPath}',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : SizedBox(
                        width: 120,
                        child: Center(
                          child: Icon(Icons.error),
                        ),
                      ),
              ),
            ),
          );
        },
        itemCount: series.length,
      ),
    );
  }
}
