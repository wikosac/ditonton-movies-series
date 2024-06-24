import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
  }) : super(MovieDetailInitial());

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  void fetchMovieDetail(int id) async {
    emit(MovieDetailLoading());
    final detailResult = await getMovieDetail.execute(id);
    final recommendationsResult = await getMovieRecommendations.execute(id);
    detailResult.fold((failure) async {
      emit(MovieDetailError(failure.message));
    }, (movieDetail) async {
      emit(MovieRecommendationsLoading());
      recommendationsResult.fold(
        (failure) async {
          emit(MovieRecommendationsError(failure.message));
        },
        (recommendationsMovie) async {
          emit(MovieDetailLoaded(movieDetail, recommendationsMovie));
        },
      );
    });
  }
}
