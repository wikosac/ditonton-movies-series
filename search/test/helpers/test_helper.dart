import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:search/search.dart';

@GenerateMocks([
  SearchRepository,
  SearchDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
