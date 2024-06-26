import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:movies/data/sources/movie_remote_data_source.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
