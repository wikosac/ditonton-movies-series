import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movies/data/sources/movie_remote_data_source.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
