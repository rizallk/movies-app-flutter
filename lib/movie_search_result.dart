import 'movie_model.dart';

class MovieSearchResult {
  final List<Movie> results;

  MovieSearchResult({required this.results});

  factory MovieSearchResult.fromJson(Map<String, dynamic> json) {
    List<Movie> movies = [];
    for (var result in json['results']) {
      movies.add(Movie.fromJson(result));
    }
    return MovieSearchResult(results: movies);
  }
}
