import 'package:equatable/equatable.dart';

import '../../domain/entities/watchlist.dart';

class WatchlistTable extends Equatable {
  const WatchlistTable({
    required this.id,
    required this.posterPath,
    required this.mediaType,
  });

  final int id;
  final String posterPath;
  final String mediaType;

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
        id: map['id'],
        posterPath: map['posterPath'],
        mediaType: map['mediaType'],
      );

  factory WatchlistTable.fromWatchlist(Watchlist watchlist) => WatchlistTable(
        id: watchlist.id,
        posterPath: watchlist.posterPath,
        mediaType: watchlist.mediaType,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'posterPath': posterPath,
        'mediaType': mediaType,
      };

  Watchlist toWatchlist() => Watchlist(
        id: id,
        posterPath: posterPath,
        mediaType: mediaType,
      );

  @override
  List<Object?> get props => [id];
}
