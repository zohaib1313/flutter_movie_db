import 'movie.dart';

class MovieResponse {
  final List<Movie> results;

  MovieResponse({required this.results});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      results: (json['results'] as List)
          .map((item) => Movie.fromJson(item))
          .toList(),
    );
  }
}
