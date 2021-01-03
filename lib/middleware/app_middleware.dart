import 'package:google_hw/actions/index.dart';
import 'package:google_hw/data/yts_api.dart';
import 'package:google_hw/models/index.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

/// Class is not used anymore; Replaced by app_epics.dart
class AppMiddleware {
  const AppMiddleware({@required YtsApi ytsApi})
      : assert(ytsApi != null),
        _ytsApi = ytsApi;

  final YtsApi _ytsApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, GetMoviesStart>(_getMoviesStart),
    ];
  }

  Future<void> _getMoviesStart(Store<AppState> store, GetMoviesStart action, NextDispatcher next) async {
    next(action);

    try {
      final List<Movie> movies = await _ytsApi.getMovies(
        action.page,
        store.state.quality,
        store.state.genres.asList(),
        store.state.orderBy,
        store.state.sortBy,
      );
      final GetMovies successful = GetMovies.successful(movies);
      store.dispatch(successful);
    } catch (e) {
      final GetMovies error = GetMovies.error(e);
      store.dispatch(error);
    }
  }
}
