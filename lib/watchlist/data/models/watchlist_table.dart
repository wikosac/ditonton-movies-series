import 'package:equatable/equatable.dart';

class WatchlistTable extends Equatable {
  const WatchlistTable({required this.id, required this.posterPath});

  final int id;
  final String posterPath;

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
    id: map['id'],
    posterPath: map['posterPath'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'posterPath': posterPath,
  };

  @override
  List<Object?> get props => [id];
}
