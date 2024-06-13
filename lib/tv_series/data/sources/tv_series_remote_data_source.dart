import 'dart:convert';

import 'package:ditonton/core/errors/exception.dart';
import 'package:ditonton/core/utils/constants.dart';
import 'package:ditonton/tv_series/data/models/tv_detail_response.dart';
import 'package:ditonton/tv_series/data/models/tv_response.dart';
import 'package:http/http.dart' as http;

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  TvSeriesRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<TvDetailResponse> getTvSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
      print(response.body);
    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: response.body);
    }
  }

  @override
  Future<TvResponse> getTvSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: response.body);
    }
  }

  @override
  Future<TvResponse> getNowPlayingTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: response.body);
    }
  }

  @override
  Future<TvResponse> getPopularTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: response.body);
    }
  }

  @override
  Future<TvResponse> getTopRatedTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: response.body);
    }
  }
}

abstract class TvSeriesRemoteDataSource {
  Future<TvResponse> getNowPlayingTvSeries();

  Future<TvResponse> getPopularTvSeries();

  Future<TvResponse> getTopRatedTvSeries();

  Future<TvDetailResponse> getTvSeriesDetail(int id);

  Future<TvResponse> getTvSeriesRecommendations(int id);
}
