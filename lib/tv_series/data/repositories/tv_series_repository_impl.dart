import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/core/errors/exception.dart';
import 'package:ditonton/core/errors/failure.dart';
import 'package:ditonton/core/utils/typedef.dart';
import 'package:ditonton/tv_series/data/sources/tv_series_remote_data_source.dart';
import 'package:ditonton/tv_series/domain/entities/episode.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  TvSeriesRepositoryImpl({required this.tvSeriesRemoteDataSource});

  final TvSeriesRemoteDataSource tvSeriesRemoteDataSource;

  @override
  ResultFuture<List<TvSeries>> getNowPlayingTvSeries() async {
    try {
      final result = await tvSeriesRemoteDataSource.getNowPlayingTvSeries();
      final data = result.results.map((item) => item.toEntity()).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  ResultFuture<List<TvSeries>> getPopularTvSeries() async {
    try {
      final result = await tvSeriesRemoteDataSource.getPopularTvSeries();
      final data = result.results.map((item) => item.toEntity()).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  ResultFuture<List<TvSeries>> getTopRatedTvSeries() async {
    try {
      final result = await tvSeriesRemoteDataSource.getTopRatedTvSeries();
      final data = result.results.map((item) => item.toEntity()).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  ResultFuture<TvSeriesDetail> getTvSeriesDetail(int id) async {
    try {
      final result = await tvSeriesRemoteDataSource.getTvSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  ResultFuture<List<TvSeries>> getTvSeriesRecommendations(int id) async {
    try {
      final result = await tvSeriesRemoteDataSource.getTvSeriesRecommendations(id);
      final data = result.results.map((item) => item.toEntity()).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  ResultFuture<List<Episode>> getTvSeriesSeason(int id, int seasonNumber) async {
    try {
      final result = await tvSeriesRemoteDataSource.getTvSeriesSeason(id, seasonNumber);
      final data = result.episodes.map((item) => item.toEntity()).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
