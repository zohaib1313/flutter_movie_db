abstract class MovieDetailEvent {}

class LoadMovieDetail extends MovieDetailEvent {
  final int movieId;
  LoadMovieDetail(this.movieId);
}
