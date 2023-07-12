import 'package:http/http.dart' as http;
import 'dart:convert';


class Movie {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  String poster;

  Movie(this.title, this.year, this.imdbID, this.type, this.poster) {
    if (poster == "N/A") {
      poster = "https://media.comicbook.com/files/img/default-movie.png";
    }
  }
}

class ApiService {
  Future<List<Movie>> getMovie(String searchEntry) async {
    List<Movie> movies = [];
    var response = await http.get(Uri.http('omdbapi.com', '/', {
      's': searchEntry,
      'apikey': 'c1a81a38',
    }));
    var jsonData = jsonDecode(response.body);
    for (var i in jsonData['Search']) {
      final movie = Movie(
        i['Title'],
        i['Year'],
        i['imdbID'],
        i['Type'],
        i['Poster'],
      );
      movies.add(movie);
    }
    return movies;
  }
}
