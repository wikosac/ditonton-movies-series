import 'package:equatable/equatable.dart';

class Search extends Equatable {
  const Search({
    required this.id,
    this.posterPath,
    this.title,
    this.releaseDate,
    this.type
  });

  final int id;
  final String? posterPath;
  final String? title;
  final String? releaseDate;
  final String? type;

  @override
  List<Object?> get props => [id];
}
