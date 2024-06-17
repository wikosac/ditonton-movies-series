import 'package:equatable/equatable.dart';

class Watchlist extends Equatable {
  const Watchlist({
    required this.id,
    required this.posterPath,
    required this.mediaType,
  });

  final int id;
  final String posterPath;
  final String mediaType;

  @override
  List<Object?> get props => [id];
}
