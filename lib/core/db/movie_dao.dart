import 'package:floor/floor.dart';

import '../../features/movies/data/models/movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM movies')
  Future<List<Movie>> getAllMovies();

  @Query('SELECT * FROM movies WHERE title LIKE :query')
  Future<List<Movie>> searchMovies(String query);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovies(List<Movie> movies);

  @Query('DELETE FROM movies')
  Future<void> clearMovies();
}
