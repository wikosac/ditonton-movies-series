import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:search/search.dart';

@GenerateMocks([
  SearchRepository,
  SearchDataSource,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
