import 'package:ditonton/movies/data/models/genre_model.dart';
import 'package:ditonton/movies/data/models/movie_detail_model.dart';
import 'package:ditonton/movies/data/models/movie_table.dart';
import 'package:ditonton/movies/domain/entities/genre.dart';
import 'package:ditonton/movies/domain/entities/movie.dart';
import 'package:ditonton/movies/domain/entities/movie_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: '/path.jpg',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'Original Title',
  overview: 'Overview',
  posterPath: '/path.jpg',
  releaseDate: '2020-05-05',
  runtime: 120,
  title: 'Title',
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'Title',
  posterPath: '/path.jpg',
  overview: 'Overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'Title',
  posterPath: '/path.jpg',
  overview: 'Overview',
);

final testMovieMap = {
  'id': 1,
  'title': 'Title',
  'posterPath': '/path.jpg',
  'overview': 'Overview',
};

final testMovieDetailModel = MovieDetailResponse(
  adult: false,
  backdropPath: "/path.jpg",
  budget: 100,
  genres: [GenreModel(id: 1, name: "Action")],
  homepage: "https://google.com",
  id: 1,
  imdbId: "imdb1",
  originalLanguage: "en",
  originalTitle: "Original Title",
  overview: "Overview",
  popularity: 1.0,
  posterPath: "/path.jpg",
  releaseDate: "2020-05-05",
  revenue: 12000,
  runtime: 120,
  status: "Status",
  tagline: "Tagline",
  title: "Title",
  video: false,
  voteAverage: 1.0,
  voteCount: 1,
);
