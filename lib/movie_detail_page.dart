import 'package:flutter/material.dart';
import 'app_constant.dart';
import 'package:cinemav_app/api_service.dart';
import 'movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final ApiService apiService = ApiService();
  final Movie movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan halaman detail movie
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            toolbarHeight: 80.0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            centerTitle: true,
            elevation: 0),
        body: FutureBuilder(
          future: apiService.getMovieById('${movie.id}'),
          builder: (context, movieDetailSnapshot) {
            if (movieDetailSnapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (movieDetailSnapshot.hasError) {
              return Center(child: Text('Error: ${movieDetailSnapshot.error}'));
            } else {
              Map<String, dynamic>? result = movieDetailSnapshot.data;

              return SingleChildScrollView(
                  child: Stack(children: [
                Column(
                  children: [
                    // Widget pertama (background)
                    Container(
                      width: double.infinity,
                      color: Colors.white.withOpacity(0.3),
                      height: 610,
                      child: Image.network(
                        '${AppConstant.imageOriginal}${result?['poster_path']}',
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      // height: 500,
                      // color: Colors.blue,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Genres',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 6.0),
                              // Text('${result?['genres'][0]['name']}',
                              //     style: TextStyle(
                              //         fontFamily: 'Inter',
                              //         color: Color(0xFFBDBDBD))),
                              Row(children: [
                                for (int i = 0;
                                    i < result?['genres'].length;
                                    i++)
                                  if (i == 0)
                                    Text('${result?['genres'][i]['name']}')
                                  else
                                    Text(', ${result?['genres'][i]['name']}')
                              ]),
                              SizedBox(height: 23.0),
                              Text(
                                'Duration',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 6.0),
                              Text('${result?['runtime']} minutes',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFFBDBDBD))),
                              SizedBox(height: 23.0),
                              Text(
                                'Released Date',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 6.0),
                              Text('${result?['release_date']}',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFFBDBDBD))),
                              SizedBox(height: 23.0),
                              Text(
                                'Overview',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 6.0),
                              Text('${result?['overview']}',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFFBDBDBD))),
                              SizedBox(height: 23.0),
                            ],
                          )),
                    ),
                    // Container(
                    //   width: 100,
                    //   height: 500,
                    //   color: Colors.yellow,
                    // )
                  ],
                ),
                Positioned(
                    top: 360,
                    child: Container(
                      width: 1000,
                      height: 260.0,
                      // color: Colors.yellow.withOpacity(0.8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black],
                        ),
                      ),
                    )),
                Positioned(
                  child: Padding(
                      padding: EdgeInsets.only(top: 435),
                      child: Center(
                          child: Column(children: [
                        Container(
                          width: 340,
                          // height: 60,
                          // color: Colors.green,
                          child: Center(
                              child: Text(
                            '${result?['title']}'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 28.0,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          'Rating: ${result?['vote_average']}',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              // fontSize: 12.0,
                              color: Color(0xFFFFD700)),
                        ),
                      ]))),
                )
              ]));
            }
          },
        ));
  }
}
