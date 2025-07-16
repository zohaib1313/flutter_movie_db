import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../movies/data/repositories/movie_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<SearchTextChanged>((event, emit) async {
      emit(SearchLoading());

      try {
        final results = await repository.searchMovies(event.query);
        emit(SearchSuccess(results));
      } catch (e) {
        print("exception in searching... ${e}");
        emit(SearchError("Failed to search movies"));
      }
    });
  }
}
