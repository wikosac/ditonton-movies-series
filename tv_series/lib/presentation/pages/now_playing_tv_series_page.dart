import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tv_series/tv_series.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  const NowPlayingTvSeriesPage({super.key});

  @override
  NowPlayingTvSeriesPageState createState() => NowPlayingTvSeriesPageState();
}

class NowPlayingTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NowPlayingTvCubit>().fetchNowPlayingTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air Series'),
      ),
      body: BlocBuilder<NowPlayingTvCubit, NowPlayingTvState>(
        builder: (context, state) {
          if (state is NowPlayingTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NowPlayingTvLoaded) {
            final items = state.series;
            return _buildAlignedGridView(items);
          } else if (state is NowPlayingTvError) {
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

  AlignedGridView _buildAlignedGridView(List<TvSeries> items) {
    return AlignedGridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final series = items[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              TV_DETAIL_ROUTE,
              arguments: series.id,
            );
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: CachedNetworkImage(
              imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
