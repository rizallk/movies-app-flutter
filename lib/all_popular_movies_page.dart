import 'package:cinemav_app/all_top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'movie_model.dart';

class AllPopularMoviesPage extends StatefulWidget {
  @override
  _AllPopularMoviesPageState createState() => _AllPopularMoviesPageState();
}

class _AllPopularMoviesPageState extends State<AllPopularMoviesPage> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Popular Movies',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 80.0,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: apiService
            .getPopularMovies(), // Anda perlu menambahkan metode getPopularMovies di ApiService
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Movie> popularMovies = List<Movie>.from(
              (snapshot.data?['results'] as List)
                  .map((movie) => Movie.fromJson(movie)),
            );

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: popularMovies.length,
              itemBuilder: (context, index) {
                return MovieGridItem(movie: popularMovies[index]);
              },
            );
          }
        },
      ),
    );
  }
}
