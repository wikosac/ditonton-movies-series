import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../provider/popular_tv_series_notifier.dart';

class PopularTvSeriesPage extends StatefulWidget {

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvSeriesNotifier>(context, listen: false)
            .fetchPopularTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Series'),
      ),
      body: Consumer<PopularTvSeriesNotifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == RequestState.Loaded) {
            return AlignedGridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: data.tvSeries.length,
              itemBuilder: (context, index) {
                final series = data.tvSeries[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      TV_DETAIL_ROUTE,
                      arguments: series.id,
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: CachedNetworkImage(
                      imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
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
}
