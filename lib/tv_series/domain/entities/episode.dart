import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String? stillPath;
  final String title;
  final int seasonNumber;
  final int episodeNumber;
  final String? airDate;
  final int? runtime;

  Episode({
    required this.id,
    required this.stillPath,
    required this.title,
    required this.airDate,
    required this.seasonNumber,
    required this.episodeNumber,
    required this.runtime,
  });

  @override
  List<Object?> get props => [id];
}
