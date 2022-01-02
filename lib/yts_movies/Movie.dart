import 'dart:convert';
import 'package:http/http.dart';

void main() {
  firstTrial();
  theTrueWay();
}

void firstTrial() {
  get('https://yts.mx/api/v2/list_movies.json').then((Response response) {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    print(jsonData['data']['movies'][0]['title']);
  });
}

Future<void> theTrueWay() async {
  final Response response = await get('https://yts.mx/api/v2/list_movies.json');
  final Map<String, dynamic> responseMap = jsonDecode(response.body);
  print(responseMap['data']['movies'][1]['title']);
}
