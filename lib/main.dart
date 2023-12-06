import 'package:cinemav_app/all_popular_movies_page.dart';
import 'package:cinemav_app/all_top_rated_movies_page.dart';
import 'package:cinemav_app/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'movie_model.dart';
import 'movie_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();
  final TextEditingController searchController = TextEditingController();

  void searchMovies(String searchTerm) {
    print('Searching for movies with keyword: $searchTerm');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to CinemaV!',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Let's relax & watch a movie!",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: apiService.getDiscoverMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Movie> movies = List<Movie>.from(
                  (snapshot.data?['results'] as List)
                      .map((movie) => Movie.fromJson(movie)));

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Search Movie, Genre...',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF4F4E4E),
                                        fontFamily: 'Inter',
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF201E1E),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 16.0),
                                      prefixIcon: Icon(Icons.search,
                                          color: Color(0xFF4F4E4E)),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    'Discover Movies',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          MovieCarousel(movies: movies),
                          SizedBox(height: 16.0),
                          FutureBuilder(
                            future: apiService.getTopRatedMovies(),
                            builder: (context, topRatedSnapshot) {
                              if (topRatedSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (topRatedSnapshot.hasError) {
                                return Center(
                                    child: Text(
                                        'Error: ${topRatedSnapshot.error}'));
                              } else {
                                List<Movie> topRatedMovies = List<Movie>.from(
                                  (topRatedSnapshot.data?['results'] as List)
                                      .map((movie) => Movie.fromJson(movie)),
                                );

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Top Rated Movies',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AllTopRatedMoviesPage()),
                                            );
                                          },
                                          child: Text(
                                            'See All',
                                            style: TextStyle(
                                              color: Color(0xFFFFD700),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 150.0,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: topRatedMovies.map((movie) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MovieWidget(
                                                movie: movie, isPotrait: true),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          FutureBuilder(
                            future: apiService.getPopularMovies(),
                            builder: (context, popularSnapshot) {
                              if (popularSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (popularSnapshot.hasError) {
                                return Center(
                                    child: Text(
                                        'Error: ${popularSnapshot.error}'));
                              } else {
                                List<Movie> popularMovies = List<Movie>.from(
                                  (popularSnapshot.data?['results'] as List)
                                      .map((movie) => Movie.fromJson(movie)),
                                );

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Popular Movies',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AllPopularMoviesPage()),
                                            );
                                          },
                                          child: Text(
                                            'See All',
                                            style: TextStyle(
                                              color: Color(0xFFFFD700),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 150.0,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: popularMovies.map((movie) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MovieWidget(
                                                movie: movie, isPotrait: true),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class MovieCarousel extends StatelessWidget {
  final List<Movie> movies;

  MovieCarousel({required this.movies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      options: CarouselOptions(
        height: 400.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return MovieWidget(movie: movies[index]);
      },
    );
  }
}
