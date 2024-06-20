import 'package:equatable/equatable.dart';

import '../../domain/entities/episode.dart';

class SeasonResponse extends Equatable {
  final String id;
  final String? airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int seasonResponseId;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  SeasonResponse({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonResponseId,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory SeasonResponse.fromJson(Map<String, dynamic> json) => SeasonResponse(
        id: json["_id"],
        airDate: json["air_date"],
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonResponseId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": seasonResponseId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };

  @override
  List<Object?> get props => [
    id,
    airDate,
    episodes,
    name,
    overview,
    seasonResponseId,
    posterPath,
    seasonNumber,
    voteAverage,
  ];
}

class EpisodeModel extends Equatable {
  final String? airDate;
  final int episodeNumber;
  final String episodeType;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;
  final List<Crew> crew;
  final List<Crew> guestStars;

  EpisodeModel({
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    required this.crew,
    required this.guestStars,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        episodeType: json["episode_type"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        guestStars:
            List<Crew>.from(json["guest_stars"].map((x) => Crew.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
        "guest_stars": List<dynamic>.from(guestStars.map((x) => x.toJson())),
      };

  Episode toEntity() => Episode(
        id: id,
        stillPath: stillPath,
        title: name,
        airDate: airDate,
        seasonNumber: seasonNumber,
        episodeNumber: episodeNumber,
        runtime: runtime,
      );

  @override
  List<Object?> get props => [
    airDate,
    episodeNumber,
    episodeType,
    id,
    name,
    overview,
    productionCode,
    runtime,
    seasonNumber,
    showId,
    stillPath,
    voteAverage,
    voteCount,
    crew,
    guestStars,
  ];
}

class Crew extends Equatable {
  final String? job;
  final Department? department;
  final String creditId;
  final bool adult;
  final int gender;
  final int id;
  final Department? knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String? character;
  final int? order;

  Crew({
    this.job,
    this.department,
    required this.creditId,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.character,
    this.order,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        job: json["job"],
        department: departmentValues.map[json["department"]],
        creditId: json["credit_id"],
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: departmentValues.map[json["known_for_department"]],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        character: json["character"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "job": job,
        "department": departmentValues.reverse[department],
        "credit_id": creditId,
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": departmentValues.reverse[knownForDepartment],
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "character": character,
        "order": order,
      };

  @override
  List<Object?> get props => [
    job,
    department,
    creditId,
    adult,
    gender,
    id,
    knownForDepartment,
    name,
    originalName,
    popularity,
    profilePath,
    character,
    order,
  ];
}

enum Department { ACTING, DIRECTING, WRITING }

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Directing": Department.DIRECTING,
  "Writing": Department.WRITING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
