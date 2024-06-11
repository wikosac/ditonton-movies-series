import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.id,
    required this.title,
    required this.year,
    required this.seasonCount,
    required this.lang,
    required this.image,
    required this.genres,
    required this.overview,
    required this.seasons,
  });

  final String id;
  final String title;
  final String year;
  final String seasonCount;
  final String lang;
  final String image;
  final String genres;
  final String overview;
  final List<Season> seasons;

  @override
  List<Object?> get props => [id];
}

class Season extends Equatable {
  final int id;
  final String name;
  final int seasonNumber;

  Season({
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