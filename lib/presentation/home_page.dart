import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_hw/actions/index.dart';
import 'package:google_hw/containers/index.dart';
import 'package:google_hw/models/index.dart';
import 'package:google_hw/presentation/movie_detailed_page.dart';
import 'package:redux/src/store.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IsLoadingContainer(
      builder: (BuildContext context, bool isLoading) {
        return MoviesContainer(
          builder: (BuildContext context, List<Movie> movies) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('YTS Movies Redux'),
                centerTitle: true,
                actions: <Widget>[
                  OrderByContainer(
                    builder: (BuildContext context, String orderBy) {
                      return IconButton(
                        icon: Icon(orderBy == 'desc' ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded),
                        onPressed: () {
                          final Store<AppState> store = StoreProvider.of<AppState>(context);

                          if (orderBy == 'desc') {
                            store.dispatch(const SetOrderBy('asc'));
                          } else {
                            store.dispatch(const SetOrderBy('desc'));
                          }

                          store.dispatch(const GetMovies.start(1));
                        },
                      );
                    },
                  ),
                ],
              ),
              body: Builder(
                builder: (BuildContext context) {
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    children: <Widget>[
                      GenresContainer(
                        builder: (BuildContext context, List<String> genres) {
                          return Wrap(
                            spacing: 8.0,
                            children: <String>[
                              'Action',
                              'Adventure',
                              'Animation',
                              'Comedy',
                              'Fantasy',
                              'History',
                              'Horror',
                              'Mystery',
                              'Romance',
                              'Sci-Fi',
                              'Superhero',
                              'Thriller',
                              'War',
                              'Western',
                            ].map((String genre) {
                              return ChoiceChip(
                                label: Text(genre),
                                selected: genres.contains(genre),
                                onSelected: (bool isSelected) {
                                  if (isSelected) {
                                    StoreProvider.of<AppState>(context)
                                      ..dispatch(SetGenres(<String>[genre]))
                                      ..dispatch(const GetMovies.start(1));
                                  } else {
                                    StoreProvider.of<AppState>(context)
                                      ..dispatch(const SetGenres(<String>[]))
                                      ..dispatch(const GetMovies.start(1));
                                  }
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          QualityContainer(
                            builder: (BuildContext context, String quality) {
                              return DropdownButton<String>(
                                value: quality,
                                hint: const Text('All'),
                                onChanged: (String value) {
                                  StoreProvider.of<AppState>(context)
                                    ..dispatch(SetQuality(value))
                                    ..dispatch(const GetMovies.start(1));
                                },
                                items: <String>[null, '720p', '1080p', '2160p', '3D'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value ?? 'All'),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          SortByContainer(
                            builder: (BuildContext context, String sortBy) {
                              return DropdownButton<String>(
                                value: sortBy,
                                hint: const Text('date added'),
                                onChanged: (String value) {
                                  StoreProvider.of<AppState>(context)
                                    ..dispatch(SetSortBy(value))
                                    ..dispatch(const GetMovies.start(1));
                                },
                                // add mapping like "Rating: rating" instead of using list
                                items: <String>[null, 'rating', 'year', 'title'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value ?? 'date added'),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8.0).copyWith(bottom: 56.0),
                          itemCount: movies.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final Movie movie = movies[index];

                            return GestureDetector(
                              child: GridTile(
                                child: Image.network(movie.mediumCover),
                                footer: GridTileBar(
                                  title: Text(movie.title),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<MoviePage>(builder: (BuildContext context) => MoviePage(movie)),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        child: const Text('Load more'),
                        onPressed: () {
                          final Store<AppState> store = StoreProvider.of<AppState>(context);
                          store.dispatch(GetMovies.start(store.state.page));
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
