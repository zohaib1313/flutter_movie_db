import 'package:dio/dio.dart';

import '../../../../core/db/app_database.dart';
import '../models/movie.dart';
import '../models/movie_response_wrapper.dart';

class MovieRepository {
  final Dio _dio = Dio();
  final String _apiKey = "dd5754d2c14f1c68294a91f61a7a51cb";
  final AppDatabase db;

  MovieRepository(this.db);

  Future<List<Movie>> fetchMovies({int page = 1}) async {
    try {
      print("fetching movies..... ${page}");
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/popular',
        queryParameters: {'api_key': _apiKey, 'page': page},
      );
      print("got response .... ${response}");
      if (response.statusCode == 200) {
        final movies = MovieResponse.fromJson(response.data).results;

        if (page == 1) {
          await db.movieDao.clearMovies(); // clear old cache
        }
        await db.movieDao.insertMovies(movies); // cache new data

        return movies;
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      final cached = await db.movieDao.getAllMovies();
      if (cached.isNotEmpty) {
        return cached;
      } else {
        throw Exception('No internet and no cache found: $e');
      }
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final localResults = await db.movieDao.searchMovies('%$query%');

      if (localResults.isNotEmpty) return localResults;

      final response = await _dio.get(
        'https://api.themoviedb.org/3/search/movie',
        queryParameters: {'query': query, 'api_key': _apiKey, 'page': 1},
      );

      print(response);
      if (response.statusCode == 200) {
        final List<Movie> remoteResults = (response.data['results'] as List)
            .map((json) => Movie.fromJson(json))
            .toList();

        await db.movieDao.insertMovies(remoteResults);

        return remoteResults;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }

  Future<Movie> fetchMovieDetail(int movieId) async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/$movieId',
        queryParameters: {'api_key': _apiKey},
      );

      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Error fetching movie details: $e');
    }
  }
}
