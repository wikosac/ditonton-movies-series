import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:watchlist/watchlist.dart';

@GenerateMocks([
  WatchlistRepository,
  WatchlistDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
