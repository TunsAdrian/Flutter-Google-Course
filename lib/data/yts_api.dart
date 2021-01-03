import 'dart:convert';

import 'package:google_hw/models/index.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class YtsApi {
  const YtsApi({@required Client client})
      : assert(client != null),
        _client = client;

  final Client _client;

  Future<List<Movie>> getMovies(int page, String quality, List<String> genres, String orderBy, String sortBy) async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'yts.mx',
      pathSegments: <String>['api', 'v2', 'list_movies.json'],
      queryParameters: <String, String>{
        'limit': '9',
        'page': '$page',
        'order_by': orderBy,
        if (sortBy != null) 'sort_by': sortBy,
        if (quality != null) 'quality': quality,
        if (genres.isNotEmpty) 'genre': genres.join(','),
      },
    );
    final Response response = await _client.get(url);

    final List<dynamic> data = jsonDecode(response.body)['data']['movies'];
    return data.map((dynamic json) => Movie.fromJson(json)).toList();
  }
}
