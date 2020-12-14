import 'package:meta/meta.dart';

class Movie {
  Movie(
      {@required this.title, @required this.year, @required this.rating, @required this.runtime, @required this.cover});

  final String title;
  final num year;
  final num rating;
  final num runtime;
  final String cover;

  @override
  String toString() {
    return 'Movies{title: $title, year: $year, rating: $rating, runtime: $runtime, cover: $cover}';
  }
}
