abstract class MovieDetailEvent {}

class LoadMovieDetail extends MovieDetailEvent {
  final int movieId;
  LoadMovieDetail(this.movieId);
}

class LoadMovieTrailer extends MovieDetailEvent {
  final int movieId;
  LoadMovieTrailer(this.movieId);
}
