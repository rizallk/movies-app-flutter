import 'package:cinemav_app/app_constant.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'movie_model.dart';
import 'movie_detail_page.dart';
// some changes

class AllTopRatedMoviesPage extends StatefulWidget {
  @override
  _AllTopRatedMoviesPageState createState() => _AllTopRatedMoviesPageState();
}

class _AllTopRatedMoviesPageState extends State<AllTopRatedMoviesPage> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Rated Movies',
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
        future: apiService.getTopRatedMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Movie> topRatedMovies = List<Movie>.from(
              (snapshot.data?['results'] as List)
                  .map((movie) => Movie.fromJson(movie)),
            );

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: topRatedMovies.length,
              itemBuilder: (context, index) {
                return MovieGridItem(movie: topRatedMovies[index]);
              },
            );
          }
        },
      ),
    );
  }
}

class MovieGridItem extends StatelessWidget {
  final Movie movie;

  MovieGridItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movie: movie),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: Color(0xFF4F4E4E),
                    width: 1.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    '${AppConstant.imageUrlW500}${movie.posterPath}',
                    height: 100.0,
                    width: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.0),
            Text(
              movie.title,
              style: TextStyle(
                fontSize: 8.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
