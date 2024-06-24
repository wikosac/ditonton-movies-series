import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tv_series/tv_series.dart';

class PopularTvSeriesPage extends StatefulWidget {
  const PopularTvSeriesPage({super.key});

  @override
  PopularTvSeriesPageState createState() => PopularTvSeriesPageState();
}

class PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularTvCubit>().fetchPopularTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Series'),
      ),
      body: BlocBuilder<PopularTvCubit, PopularTvState>(
        builder: (context, state) {
          if (state is PopularTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularTvLoaded) {
            final items = state.series;
            return _buildAlignedGridView(items);
          } else if (state is PopularTvError) {
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
