part of models;

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState() {
    return _$AppState((AppStateBuilder b) {
      b
        ..isLoading = false
        ..page = 1
        ..orderBy = 'desc';
    });
  }

  AppState._();

  BuiltList<Movie> get movies;

  int get page;

  @nullable
  String get quality;

  @nullable
  String get sortBy;

  String get orderBy;

  bool get isLoading;

  BuiltList<String> get genres;
}
