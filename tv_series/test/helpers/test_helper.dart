import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';

@GenerateMocks([
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
