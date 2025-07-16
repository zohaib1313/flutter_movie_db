import 'package:floor/floor.dart';

import '../../features/movies/data/models/movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM movies')
  Future<List<Movie>> getAllMovies();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovies(List<Movie> movies);

  @Query('DELETE FROM movies')
  Future<void> clearMovies();
}
