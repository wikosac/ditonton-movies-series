import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  TopRatedMoviesCubit(this._getTopRatedMovies) : super(TopRatedMoviesInitial());

  final GetTopRatedMovies _getTopRatedMovies;

  void fetchTopRatedMovies() async {
    emit(TopRatedMoviesLoading());
    final result = await _getTopRatedMovies.execute();
    result.fold((failure) async {
      emit(TopRatedMoviesError(failure.message));
    }, (data) async {
      emit(TopRatedMoviesLoaded(data));
    });
  }
}
