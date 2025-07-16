import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/features/movies/data/repositories/movie_repository.dart';

import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository repository;

  MovieDetailBloc(this.repository) : super(MovieDetailLoading()) {
    on<LoadMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final movie = await repository.fetchMovieDetail(event.movieId);
        emit(MovieDetailLoaded(movie));
      } catch (e) {
        emit(MovieDetailError('Failed to load details'));
      }
    });
  }
}
