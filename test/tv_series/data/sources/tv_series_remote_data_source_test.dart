import 'package:ditonton/core/errors/exception.dart';
import 'package:ditonton/tv_series/data/sources/tv_series_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../../json_reader.dart';
import '../../dummy/dummy_objects.dart';

void main() {
  const BASE_URL = 'https://api.themoviedb.org/3';
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';

  late TvSeriesRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  final tTvData = dummyTvResponse;
  final tResponse = readJson('tv_series/dummy/tv_response.json');
  final tDetailData = dummyTvDetailResponse;
  final tDetailResponse = readJson('tv_series/dummy/tv_detail_response.json');
  final tSeasonData = dummySeasonResponse;
  final tSeasonResponse = readJson('tv_series/dummy/tv_season_response.json');

  group('now playing', () {
    test('return TvResponse if success', () async {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')),
      ).thenAnswer((_) async => http.Response(tResponse, 200));

      final actual = await dataSource.getNowPlayingTvSeries();

      expect(actual, tTvData);
    });

    test('return Failure if unsuccessful', () {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')),
      ).thenAnswer((_) async => http.Response('', 404));

      final actual = () async => await dataSource.getNowPlayingTvSeries();

      expect(actual, throwsA(isA<ServerException>()));
    });
  });

  group('popular', () {
    test('return TvResponse if success', () async {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')),
      ).thenAnswer((_) async => http.Response(tResponse, 200));

      final actual = await dataSource.getPopularTvSeries();

      expect(actual, tTvData);
    });

    test('return Failure if unsuccessful', () {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')),
      ).thenAnswer((_) async => http.Response('', 404));

      final actual = () async => await dataSource.getPopularTvSeries();

      expect(actual, throwsA(isA<ServerException>()));
    });
  });

  group('top rated', () {
    test('return TvResponse if success', () async {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')),
      ).thenAnswer((_) async => http.Response(tResponse, 200));

      final actual = await dataSource.getTopRatedTvSeries();

      expect(actual, tTvData);
    });

    test('return Failure if unsuccessful', () {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')),
      ).thenAnswer((_) async => http.Response('', 404));

      final actual = () async => await dataSource.getTopRatedTvSeries();

      expect(actual, throwsA(isA<ServerException>()));
    });
  });

  group('detail', () {
    test('return DetailResponse if success', () async {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/1?$API_KEY')),
      ).thenAnswer((_) async => http.Response(tDetailResponse, 200));

      final actual = await dataSource.getTvSeriesDetail(1);

      expect(actual, tDetailData);
    });

    test('return Failure if unsuccessful', () {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/1?$API_KEY')),
      ).thenAnswer((_) async => http.Response('', 404));

      final actual = () async => await dataSource.getTvSeriesDetail(1);

      expect(actual, throwsA(isA<ServerException>()));
    });
  });

  group('recommendations', () {
    test('return TvResponse if success', () async {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/1/recommendations?$API_KEY')),
      ).thenAnswer((_) async => http.Response(tResponse, 200));

      final actual = await dataSource.getTvSeriesRecommendations(1);

      expect(actual, tTvData);
    });

    test('return Failure if unsuccessful', () {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/1/recommendations?$API_KEY')),
      ).thenAnswer((_) async => http.Response('', 404));

      final actual = () async => await dataSource.getTvSeriesRecommendations(1);

      expect(actual, throwsA(isA<ServerException>()));
    });
  });

  group('season', () {
    test('return SeasonResponse if success', () async {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/1/season/2?$API_KEY')),
      ).thenAnswer((_) async => http.Response(tSeasonResponse, 200));

      final actual = await dataSource.getTvSeriesSeason(1, 2);

      expect(actual, tSeasonData);
    });

    test('return Failure if unsuccessful', () {
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/tv/1/season/2?$API_KEY')),
      ).thenAnswer((_) async => http.Response('', 404));

      final actual = () async => await dataSource.getTvSeriesSeason(1, 2);

      expect(actual, throwsA(isA<ServerException>()));
    });
  });
}
