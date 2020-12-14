import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'movie.dart';
import 'movie_detailed_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YTS Movies',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const HomePage(title: 'YTS Movies'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool sortDescending = true;
  int currentPageNumber = 1;
  num movieCount = double.infinity;
  String dropdownValue = 'Latest';

  List<Movie> movieList = <Movie>[];
  Map<String, String> sortByOptions = <String, String>{
    'Latest': 'date_added',
    'Rating': 'rating',
    'Year': 'year',
    'Alphabetical': 'title'
  };

  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  Future<void> getMovieList() async {
    final String addressWithQuery =
        'https://yts.mx/api/v2/list_movies.json?page=$currentPageNumber&order_by=${sortDescending ? 'desc' : 'asc'}&sort_by=${sortByOptions[dropdownValue]}';
    final Response response = await get(addressWithQuery);

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final Map<String, dynamic> data = responseData['data'];
    final List<dynamic> movies = data['movies'];
    movieCount = data['movie_count'];
    movieList.clear();

    for (int i = 0; i < movies.length; i++) {
      final Map<String, dynamic> item = movies[i];
      final Movie movie = Movie(
        title: item['title'],
        year: item['year'],
        rating: item['rating'],
        runtime: item['runtime'],
        cover: item['medium_cover_image'],
      );

      movieList.add(movie);
    }
    setState(() {
      // movieList is changed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: sortByOptions.keys.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                FlatButton.icon(
                  label: Text(sortDescending ? 'Descending' : 'Ascending'),
                  icon: Icon(sortDescending ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded),
                  onPressed: () {
                    setState(() {
                      sortDescending = !sortDescending;
                    });
                  },
                ),
                FlatButton.icon(
                  label: const Text('Search'),
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      getMovieList();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.local_movies_rounded),
                  title: Text('${movieList[index].title}'),
                  subtitle: Text(
                      'Rating: ${movieList[index].rating}, Year: ${movieList[index].year}, Runtime: ${movieList[index].runtime}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<MoviePage>(builder: (BuildContext context) => MoviePage(movieList[index])),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Visibility(
                visible: currentPageNumber > 1,
                child: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      currentPageNumber--;
                      getMovieList();
                    });
                  },
                ),
              ),
              Text('Page: $currentPageNumber', style: const TextStyle(fontSize: 14.0)),
              Visibility(
                visible: currentPageNumber < movieCount / 20,
                child: IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      currentPageNumber++;
                      getMovieList();
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
