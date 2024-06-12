import 'package:equatable/equatable.dart';

class Search extends Equatable {
  const Search({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.year,
  });

  final int id;
  final String posterPath;
  final String title;
  final DateTime year;

  @override
  List<Object?> get props => [id];
}
