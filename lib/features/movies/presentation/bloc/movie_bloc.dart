import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;
  bool isLoadingMore = false;
  MovieBloc(this.repository) : super(MovieLoading()) {
    on<LoadMovies>(_onInitialLoad);
    on<LoadMoreMovies>(_onLoadMore);
  }

  Future<void> _onInitialLoad(
    LoadMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());
    try {
      final movies = await repository.fetchMovies(page: event.page);
      emit(MovieLoaded(movies: movies, page: 1));
    } catch (e) {
      emit(MovieError('Failed to load movies'));
    }
  }

  Future<void> _onLoadMore(
    LoadMoreMovies event,
    Emitter<MovieState> emit,
  ) async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    print("loading more.....");

    if (state is MovieLoaded) {
      final current = state as MovieLoaded;
      try {
        final newMovies = await repository.fetchMovies(page: event.page);
        if (newMovies.isEmpty) {
          emit(current.copyWith(hasReachedMax: true));
        } else {
          emit(
            current.copyWith(
              movies: current.movies + newMovies,
              page: event.page,
              hasReachedMax: false,
            ),
          );
        }
      } catch (e) {
        emit(MovieError('Failed to load more movies'));
      } finally {
        isLoadingMore = false;
      }
    }
  }
}
