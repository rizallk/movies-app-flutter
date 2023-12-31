import 'dart:convert';
import 'package:dio/dio.dart';
import 'app_constant.dart';
import 'movie_search_result.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstant.baseUrl,
    queryParameters: {'api_key': AppConstant.apiKey},
  ));

  Future<Map<String, dynamic>> getDiscoverMovies() async {
    try {
      final response = await _dio.get('/discover/movie');

      if (response.statusCode == 200) {
        return json.decode(response.toString());
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (error) {
      throw Exception('Failed to load movies: $error');
    }
  }

  Future<Map<String, dynamic>> getTopRatedMovies() async {
    try {
      final response = await _dio.get('/movie/top_rated');

      if (response.statusCode == 200) {
        return json.decode(response.toString());
      } else {
        throw Exception('Failed to load top rated movies');
      }
    } catch (error) {
      throw Exception('Failed to load top rated movies: $error');
    }
  }

  Future<Map<String, dynamic>> getPopularMovies() async {
    try {
      final response = await _dio.get('/movie/popular');

      if (response.statusCode == 200) {
        return json.decode(response.toString());
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (error) {
      throw Exception('Failed to load popular movies: $error');
    }
  }

  Future<Map<String, dynamic>> getMovieById(String movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId');

      if (response.statusCode == 200) {
        return json.decode(response.toString());
      } else {
        throw Exception('Failed to load movie');
      }
    } catch (error) {
      throw Exception('Failed to load movie: $error');
    }
  }

  Future<MovieSearchResult> searchMovie(String query) async {
    try {
      final response = await _dio.get('/search/movie?query=$query');

      print('Response data: ${response.data}');
      print('Response code: ${response.statusCode == 200}');

      if (response.statusCode == 200) {
        return MovieSearchResult.fromJson(response.data);
      } else {
        throw Exception('Failed to search movie');
      }
    } catch (error) {
      throw Exception('Failed to search movie: $error');
    }
  }
}
