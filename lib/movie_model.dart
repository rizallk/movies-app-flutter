class Movie {
  final int id;
  final int duration;
  final double rating;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final List genres;

  Movie(
      {required this.id,
      required this.duration,
      required this.rating,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      required this.genres});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        duration: json['runtime'],
        rating: json['popularity'],
        title: json['title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        genres: json['genres']);
  }
}
