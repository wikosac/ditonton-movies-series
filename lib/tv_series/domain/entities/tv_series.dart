import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  TvSeries({required this.id, this.posterPath});

  final int id;
  final String? posterPath;

  @override
  List<Object?> get props => [id, posterPath];
}
