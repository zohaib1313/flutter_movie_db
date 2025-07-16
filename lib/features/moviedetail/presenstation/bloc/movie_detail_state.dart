import '../../../movies/data/models/movie.dart';

abstract class MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final Movie movie;
  MovieDetailLoaded(this.movie);
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError(this.message);
}

class TrailerLoaded extends MovieDetailState {
  final String youtubeKey;
  TrailerLoaded(this.youtubeKey);
}
