import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit(
    this._getWatchlist,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(WatchlistInitial());

  final GetWatchlist _getWatchlist;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  void fetchWatchlist() async {
    emit(WatchlistLoading());
    final result = await _getWatchlist.execute();
    result.fold((failure) async {
      emit(WatchlistError(failure.message));
    }, (watchlist) async {
      emit(WatchlistLoaded(watchlist));
    });
  }

  void checkWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    emit(WatchlistStatus(result));
  }

  void addWatchlist(MovieDetail movie) async {
    final result = await _saveWatchlist.execute(movie.toWatchlist());
    await result.fold((failure) async {
      emit(WatchlistError(failure.message));
    }, (message) async {
      emit(WatchlistSuccess(message));
    });
    checkWatchlistStatus(movie.id);
  }

  void removeWatchlist(int id) async {
    final result = await _removeWatchlist.execute(id);
    await result.fold((failure) async {
      emit(WatchlistError(failure.message));
    }, (message) async {
      emit(WatchlistSuccess(message));
    });
    checkWatchlistStatus(id);
  }
}
