import 'package:ditonton/watchlist/domain/entities/watchlist.dart';
import 'package:equatable/equatable.dart';

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

  Watchlist toWatchlist() => Watchlist(
        id: id,
        posterPath: posterPath,
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

class Episode extends Equatable {
  final int id;
  final String image;
  final String title;
  final int seasonNumber;
  final int episodeNumber;
  final DateTime airDate;
  final int runtime;

  Episode({
    required this.id,
    required this.image,
    required this.title,
    required this.airDate,
    required this.seasonNumber,
    required this.episodeNumber,
    required this.runtime,
  });

  @override
  List<Object?> get props => [id];
}
