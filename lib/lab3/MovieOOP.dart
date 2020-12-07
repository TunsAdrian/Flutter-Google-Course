import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

Future<void> main() async {
  final Response response = await get('https://yts.mx/api/v2/list_movies.json');

  final Map<String, dynamic> responseData = jsonDecode(response.body);
  final Map<String, dynamic> data = responseData['data'];
  final List<dynamic> movies = data['movies'];

  for (int i = 0; i < movies.length; i++) {
    final Map<String, dynamic> item = movies[i];

    final Movie movie = Movie(
      id: item['id'],
      title: item['title'],
      year: item['year'],
      runtime: item['runtime'],
      cover: item['medium_cover_image'],
    );

    print(movie);
  }
}

class Movie {
  Movie({@required this.id, @required this.title, @required this.year, @required this.runtime, @required this.cover});

  final int id;
  final String title;
  final int year;
  final int runtime;
  final String cover;

  @override
  String toString() {
    return 'Movies{id: $id, title: $title, year: $year, runtime: $runtime, cover: $cover}';
  }
}
