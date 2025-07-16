import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object?> get props => [];
}

class LoadMovies extends MovieEvent {
  final int page;
  const LoadMovies({this.page = 1});
}

class LoadMoreMovies extends MovieEvent {
  final int page;
  const LoadMoreMovies({required this.page});
}
