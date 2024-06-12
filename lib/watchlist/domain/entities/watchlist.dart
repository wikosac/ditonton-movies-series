import 'package:equatable/equatable.dart';

class Watchlist extends Equatable {
  const Watchlist({required this.id, required this.posterPath});

  final int id;
  final String posterPath;

  @override
  List<Object?> get props => [id];
}
