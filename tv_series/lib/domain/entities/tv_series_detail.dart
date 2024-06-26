import 'package:equatable/equatable.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.id,
    required this.title,
    required this.year,
    required this.seasonCount,
    required this.lang,
    required this.posterPath,
    required this.genres,
    required this.overview,
    required this.seasons,
    required this.rating,
  });

  final int id;
  final String title;
  final String year;
  final int seasonCount;
  final List<String> lang;
  final String posterPath;
  final List<String> genres;
  final String overview;
  final List<SeasonEntity> seasons;
  final double rating;

  Watchlist toWatchlist() => Watchlist(
        id: id,
        posterPath: posterPath,
        mediaType: 'TV',
      );

  @override
  List<Object?> get props => [id];
}

class SeasonEntity extends Equatable {
  final int id;
  final String name;
  final int seasonNumber;

  SeasonEntity({
    required this.id,
    required this.name,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [id];
}
