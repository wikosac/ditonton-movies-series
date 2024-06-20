import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/watchlist.dart';
import '../../domain/usecases/get_watchlist.dart';

class WatchlistNotifier extends ChangeNotifier {
  var _watchlist = <Watchlist>[];

  List<Watchlist> get watchlist => _watchlist;

  var _watchlistState = RequestState.Empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  WatchlistNotifier(this.getWatchlistMovies);

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
