import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/movies.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  NowPlayingMoviesCubit(this._getNowPlayingMovies)
      : super(NowPlayingMoviesInitial());

  final GetNowPlayingMovies _getNowPlayingMovies;

  void fetchNowPlayingMovies() async {
    emit(NowPlayingMoviesLoading());
    final result = await _getNowPlayingMovies.execute();
    result.fold((failure) async {
      emit(NowPlayingMoviesError(failure.message));
    }, (data) async {
      emit(NowPlayingMoviesLoaded(data));
    });
  }
}
