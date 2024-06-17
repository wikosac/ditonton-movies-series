import 'dart:convert';

import 'package:ditonton/movies/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../json_reader.dart';

void main() {
  final tMovieDetailJson = json.decode(readJson('movie_detail.json'));
  final tMovieDetailModel = testMovieDetailModel;
  final tMovieDetail = testMovieDetail;

  test('return model from json', () {
    final actual = MovieDetailResponse.fromJson(tMovieDetailJson);
    expect(actual, tMovieDetailModel);
  });

  test('return json from model', () {
    final actual = tMovieDetailModel.toJson();
    expect(actual, tMovieDetailJson);
  });

  test('return entity from model', () {
    final actual = tMovieDetailModel.toEntity();
    expect(actual, tMovieDetail);
  });
}
