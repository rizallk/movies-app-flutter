import 'package:flutter/material.dart';
import 'movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan halaman detail movie
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
            'ID: ${movie.id}\nDuration: ${movie.duration}\nRating: ${movie.rating}\nTitle: ${movie.title}\nOverview: ${movie.overview}\nPosterPath: ${movie.posterPath}\nRelease Date: ${movie.releaseDate}\nGenres: ${movie.genres}'),
      ),
    );
  }
}
