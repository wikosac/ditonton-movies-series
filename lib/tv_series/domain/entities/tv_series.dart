import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  const TvSeries({required this.id, required this.posterPath});

  final String id;
  final String posterPath;

  @override
  List<Object?> get props => [id];
}
