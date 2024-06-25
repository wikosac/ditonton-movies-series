part of 'watchlist_cubit.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

final class WatchlistInitial extends WatchlistState {}

final class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  const WatchlistLoaded(this.watchlist);

  final List<Watchlist> watchlist;

  @override
  List<Object> get props => [watchlist];
}

class WatchlistError extends WatchlistState {
  const WatchlistError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class WatchlistStatus extends WatchlistState {
  const WatchlistStatus(this.isWatchlist);

  final bool isWatchlist;

  @override
  List<Object> get props => [isWatchlist];
}

class WatchlistSuccess extends WatchlistState {
  const WatchlistSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
