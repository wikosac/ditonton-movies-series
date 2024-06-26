import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:watchlist/watchlist.dart';

@GenerateMocks([
  WatchlistRepository,
  WatchlistDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
