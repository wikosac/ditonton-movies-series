import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:search/data/sources/search_data_source.dart';

import '../../dummy/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const BASE_URL = 'https://api.themoviedb.org/3';
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';

  late SearchDataSource searchDataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    searchDataSource = SearchDataSourceImpl(client: mockIOClient);
  });

  final tSearchList = [testSearchEntity];
  const query = 'the flash';
  final tError = ServerException(message: 'Server error');

  test('return List<Search> if success', () async {
    when(
      mockIOClient.get(
        Uri.parse('$BASE_URL/search/multi?$API_KEY&query=$query'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        readJson('dummy/search_response.json'),
        200,
      ),
    );

    final actual = await searchDataSource.search(query);

    expect(actual, tSearchList);
  });

  test('return Failure if unsuccessful', () {
    when(
      mockIOClient.get(
        Uri.parse('$BASE_URL/search/multi?$API_KEY&query=$query'),
      ),
    ).thenThrow(tError);

    actual() async => await searchDataSource.search(query);

    expect(actual, throwsA(isA<ServerException>()));
  });
}
