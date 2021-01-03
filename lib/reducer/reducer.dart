import 'package:built_collection/built_collection.dart';
import 'package:google_hw/actions/index.dart';
import 'package:google_hw/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, GetMoviesStart>(_getMoviesStart),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMovieError),
  TypedReducer<AppState, SetQuality>(_setQuality),
  TypedReducer<AppState, SetGenres>(_setGenres),
  TypedReducer<AppState, SetOrderBy>(_setOrderBy),
  TypedReducer<AppState, SetSortBy>(_setSortBy)
]);

AppState _getMoviesStart(AppState state, GetMoviesStart action) {
  return state.rebuild((AppStateBuilder b) => b.isLoading = true);
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..movies.addAll(action.movies)
      ..isLoading = false
      ..page = state.page + 1;
  });
}

AppState _getMovieError(AppState state, GetMoviesError action) {
  return state.rebuild((AppStateBuilder b) => b.isLoading = false);
}

AppState _setQuality(AppState state, SetQuality action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..quality = action.quality
      ..movies.clear();
  });
}

AppState _setGenres(AppState state, SetGenres action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..genres = ListBuilder<String>(action.genres)
      ..movies.clear();
  });
}

AppState _setOrderBy(AppState state, SetOrderBy action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..orderBy = action.orderBy
      ..movies.clear();
  });
}

AppState _setSortBy(AppState state, SetSortBy action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..sortBy = action.sortBy
      ..movies.clear();
  });
}
