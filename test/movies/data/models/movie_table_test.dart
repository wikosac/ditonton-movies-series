
import 'package:ditonton/movies/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  final tMovieTableJson = testMovieMap;
  final tMovieTable = testMovieTable;
  final tMovieDetail = testMovieDetail;
  final tWatchlistMovie = testWatchlistMovie;

  test('return table model from detail movie', () {
    final actual = MovieTable.fromEntity(tMovieDetail);
    expect(actual, tMovieTable);
  });

  test('return model from json', () {
    final actual = MovieTable.fromMap(tMovieTableJson);
    expect(actual, tMovieTable);
  });

  test('return json from model', () {
    final actual = tMovieTable.toJson();
    expect(actual, tMovieTableJson);
  });

  test('return entity from model', () {
    final actual = tMovieTable.toEntity();
    expect(actual, tWatchlistMovie);
  });
}