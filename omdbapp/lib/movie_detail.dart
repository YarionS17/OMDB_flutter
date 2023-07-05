import 'package:flutter/material.dart';
import 'package:omdbapp/movie.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(movie.imdbID),
          Text(movie.type),
          Text(movie.year),
          Image.network(movie.poster),
        ],
      )
    );
  }
}
