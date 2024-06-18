import 'package:ditonton/core/errors/exception.dart';
import 'package:ditonton/search/data/sources/search_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../../json_reader.dart';
import '../../dummy/dummy_objects.dart';

void main() {
  const BASE_URL = 'https://api.themoviedb.org/3';
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';

  late SearchDataSource searchDataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    searchDataSource = SearchDataSourceImpl(client: mockHttpClient);
  });

  final tSearchList = [testSearchEntity];
  final query = 'the flash';
  final tError = ServerException(message: 'Server error');

  test('return List<Search> if success', () async {
    when(
      mockHttpClient.get(
        Uri.parse('$BASE_URL/search/multi?$API_KEY&query=$query'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        readJson('search/dummy/search_response.json'),
        200,
      ),
    );

    final actual = await searchDataSource.search(query);

    expect(actual, tSearchList);
  });

  test('return Failure if unsuccessful', () {
    when(
      mockHttpClient.get(
        Uri.parse('$BASE_URL/search/multi?$API_KEY&query=$query'),
      ),
    ).thenThrow(tError);

    final actual = () async => await searchDataSource.search(query);

    expect(actual, throwsA(isA<ServerException>()));
  });
}
