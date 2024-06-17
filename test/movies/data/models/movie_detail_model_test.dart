import 'package:ditonton/movies/data/models/genre_model.dart';
import 'package:ditonton/movies/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  final tMovieDetail = testMovieDetail;
  final tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: "backdropPath",
    budget: 100,
    genres: [GenreModel(id: 1, name: "Action")],
    homepage: "homepage",
    id: 1,
    imdbId: "imdbId",
    originalLanguage: "originalLanguage",
    originalTitle: "originalTitle",
    overview: "overview",
    popularity: 1.0,
    posterPath: "posterPath",
    releaseDate: "releaseDate",
    revenue: 12000,
    runtime: 120,
    status: "status",
    tagline: "tagline",
    title: "title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tMovieDetailJson = {
    "adult": false,
    "backdrop_path": "backdropPath",
    "budget": 100,
    "genres": [
      {"id": 1, "name": "Action"}
    ],
    "homepage": "homepage",
    "id": 1,
    "imdb_id": "imdbId",
    "original_language": "originalLanguage",
    "original_title": "originalTitle",
    "overview": "overview",
    "popularity": 1.0,
    "poster_path": "posterPath",
    "release_date": "releaseDate",
    "revenue": 12000,
    "runtime": 120,
    "status": "status",
    "tagline": "tagline",
    "title": "title",
    "video": false,
    "vote_average": 1.0,
    "vote_count": 1
  };

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
