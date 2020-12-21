import 'dart:ui';

import 'package:flutter/material.dart';

import 'models/movie.dart';

class MoviePage extends StatelessWidget {
  const MoviePage(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(movie.mediumCover, fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Container(width: 400.0, height: 400.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(image: NetworkImage(movie.mediumCover), fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(movie.title, style: const TextStyle(color: Colors.white, fontSize: 30.0)),
                      ),
                      Text('${movie.rating}/10', style: const TextStyle(color: Colors.white, fontSize: 20.0)),
                    ],
                  ),
                ),
                Text(
                  'The movie "${movie.title}" was released on ${movie.year} and has a runtime of ${movie.runtime} minutes.',
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
