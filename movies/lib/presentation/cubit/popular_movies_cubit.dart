import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit(this._getPopularMovies) : super(PopularMoviesInitial());

  final GetPopularMovies _getPopularMovies;

  void fetchPopularMovies() async {
    emit(PopularMoviesLoading());
    final result = await _getPopularMovies.execute();
    result.fold((failure) async {
      emit(PopularMoviesError(failure.message));
    }, (data) async {
      emit(PopularMoviesLoaded(data));
    });
  }
}
