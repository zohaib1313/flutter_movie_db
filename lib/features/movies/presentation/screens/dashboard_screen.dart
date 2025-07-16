import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_booking_app/core/theme/app_colors.dart';

import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/movie_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    final bloc = context.read<MovieBloc>();
    final state = bloc.state;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        state is MovieLoaded &&
        !state.hasReachedMax &&
        !bloc.isLoadingMore) {
      // Prevent multiple calls
      print("Loading more movies...");
      bloc.add(LoadMoreMovies(page: state.page + 1));
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load initial movies
    context.read<MovieBloc>().add(LoadMovies());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,

      ///this is not setup fully functional...keeping time constraint in mind....
      bottomNavigationBar: FigmaStyledBottomNavBar(),
      body: SafeArea(
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieLoaded) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 12.w,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 12.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Watch",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                        ),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColors.lightGrey,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 30.h,
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.hasReachedMax
                            ? state.movies.length
                            : state.movies.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.movies.length) {
                            return MovieCard(movie: state.movies[index]);
                          } else {
                            // Loader shown only if more data is being fetched
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text("Error loading movies"));
            }
          },
        ),
      ),
    );
  }
}
