import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/movies/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ItemCard extends StatelessWidget {
  ItemCard({required this.id, required this.posterPath});

  final int id;
  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            MovieDetailPage.ROUTE_NAME,
            arguments: id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
