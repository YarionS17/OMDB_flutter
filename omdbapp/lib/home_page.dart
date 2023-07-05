import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';
import 'package:omdbapp/movie_detail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> movies = [];
  String searchEntry = '';

  // get movies
  Future getMovie(String searchEntry) async {
    var response = await http.get(Uri.http('omdbapi.com', '/', {
      's': searchEntry,
      'apikey': 'c1a81a38',
    })); //('omdbapi.com', '?i=tt3896198&apikey=c1a81a38')); //('balldontlie.io','api/v1/teams')); //
    var jsonData = jsonDecode(response.body);
    for (var i in jsonData['Search']) {
      final movie = Movie(
        title: i['Title'],
        year: i['Year'],
        imdbID: i['imdbID'],
        type: i['Type'],
        poster: i['Poster'],
      );
      movies.add(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sample Code'),
        ),
        body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    setState(() {
                      movies.clear();
                      searchEntry = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                  child: FutureBuilder(
                      future: getMovie(searchEntry),
                      builder: (context, snapshot) {
                        //is done loading => show data
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.network(movies[index].poster),
                                title: Column(
                                  children: <Widget>[
                                    ElevatedButton(
                                        child: Text(movies[index].title),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SecondRoute(movie: movies[index])),
                                          );
                                        })
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        // show loading
                        else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }))
            ]));
  }
}
