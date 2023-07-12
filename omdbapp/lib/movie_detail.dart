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
      body: Card(      
        child: Column(
          children: <Widget>[  
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10.0),
          height: 500,
          child: 
          Image.network(movie.poster, width: double.infinity, fit: BoxFit.fitWidth,)
        ),
        Text(movie.title),
        Text(movie.imdbID),
        Text(movie.type),
        Text(movie.year),
      ],)        
      )
    );
  }
}
