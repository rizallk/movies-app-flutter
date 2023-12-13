import 'package:flutter/material.dart';
import 'api_service.dart';
import 'movie_model.dart';
import 'movie_search_result.dart';
import 'movie_detail_page.dart';
import 'app_constant.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiService apiService = ApiService();
  final TextEditingController searchController = TextEditingController();
  Future<MovieSearchResult>? _searchFuture;
  String test = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(
            fontFamily: 'Inter',
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: searchController,
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                _searchMovie(value);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Type here...',
                              hintStyle: TextStyle(
                                color: Color(0xFF4F4E4E),
                                fontFamily: 'Inter',
                              ),
                              filled: true,
                              fillColor: Color(0xFF201E1E),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              prefixIcon:
                                  Icon(Icons.search, color: Color(0xFF4F4E4E)),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          FutureBuilder<MovieSearchResult>(
                            future: _searchFuture,
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Center(
                                      child: Column(children: [
                                    SizedBox(height: 180.0),
                                    Image.asset(
                                      'assets/images/movies.png',
                                      scale: 2.5,
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      'Type the movie title',
                                      style: TextStyle(
                                          color: Color(0xFF7E7E7E),
                                          fontFamily: 'Inter'),
                                    )
                                  ]));
                                case ConnectionState.active:
                                case ConnectionState.waiting:
                                  return Center(
                                      child: Column(children: [
                                    SizedBox(height: 50.0),
                                    CircularProgressIndicator()
                                  ]));
                                case ConnectionState.done:
                                  if (snapshot.hasError)
                                    return Text('Error: ${snapshot.error}');
                                  else if (snapshot.data!.results.isNotEmpty) {
                                    final searchResults =
                                        snapshot.data!.results;

                                    return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Search result',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 8.0),
                                          Column(
                                            children: searchResults
                                                .map((movie) => ListTile(
                                                      title: Text(
                                                        movie.title,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      // Tambahkan logika navigasi atau tindakan lain di sini
                                                    ))
                                                .toList(),
                                          )
                                        ]);
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Search result',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ]),
                                        Center(
                                            child: Column(
                                          children: [
                                            SizedBox(height: 200.0),
                                            Text(
                                              'No results page.',
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text(
                                              "we can't find any item matching\nyour search",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Color(0xFF7E7E7E),
                                              ),
                                            )
                                          ],
                                        ))
                                      ],
                                    );
                                  }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchMovie(String query) {
    setState(() {
      _searchFuture = apiService.searchMovie(query);
    });
  }
}
