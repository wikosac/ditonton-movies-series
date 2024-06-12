import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/watchlist/domain/entities/watchlist.dart';
import 'package:ditonton/watchlist/domain/usecases/get_watchlist.dart';
import 'package:flutter/foundation.dart';

class WatchlistNotifier extends ChangeNotifier {
  var _watchlist = <Watchlist>[];

  List<Watchlist> get watchlist => _watchlist;

  var _watchlistState = RequestState.Empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  WatchlistNotifier({required this.getWatchlistMovies});

  final GetWatchlist getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (watchlistData) {
        _watchlistState = RequestState.Loaded;
        _watchlist = watchlistData;
        notifyListeners();
      },
    );
  }
}
