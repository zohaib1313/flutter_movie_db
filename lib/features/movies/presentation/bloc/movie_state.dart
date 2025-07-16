import 'package:equatable/equatable.dart';

import '../../data/models/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object?> get props => [];
}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final int page;
  final bool hasReachedMax;

  const MovieLoaded({
    required this.movies,
    required this.page,
    this.hasReachedMax = false,
  });

  MovieLoaded copyWith({List<Movie>? movies, int? page, bool? hasReachedMax}) {
    return MovieLoaded(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [movies, page, hasReachedMax];
}

class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);
  @override
  List<Object?> get props => [message];
}
