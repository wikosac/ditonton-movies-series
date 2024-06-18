import 'package:ditonton/movies/data/sources/movie_remote_data_source.dart';
import 'package:ditonton/movies/domain/repositories/movie_repository.dart';
import 'package:ditonton/search/data/sources/search_data_source.dart';
import 'package:ditonton/search/domain/repositories/search_repository.dart';
import 'package:ditonton/watchlist/data/sources/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  SearchRepository,
  SearchDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
