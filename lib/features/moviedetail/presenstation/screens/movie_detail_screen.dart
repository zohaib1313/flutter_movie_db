import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_booking_app/core/theme/app_colors.dart';
import 'package:movie_booking_app/features/trailer/presentation/screens/movie_trailer_screen.dart';

import '../bloc/movie_detail_bloc.dart';
import '../bloc/movie_detail_event.dart';
import '../bloc/movie_detail_state.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return BlocProvider(
      create: (_) =>
          MovieDetailBloc(context.read())..add(LoadMovieDetail(movieId)),
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
          listener: (context, state) {
            if (state is TrailerLoaded) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return FullScreenTrailerPlayerScreen(
                      youtubeKey: state.youtubeKey,
                    );
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailLoaded) {
              final movie = state.movie;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            height: 340.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 48.h,
                          left: 16.w,
                          child: CircleAvatar(
                            backgroundColor: AppColors.light.withOpacity(0.7),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.dark,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 56.h,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              'Watch',
                              style: textTheme.headlineLarge?.copyWith(
                                color: AppColors.light,
                                fontSize: 20.h,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0.w,
                              vertical: 16.h,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  style: textTheme.headlineLarge?.copyWith(
                                    color: AppColors.light,
                                    fontSize: 24.h,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 8,
                                        color: Colors.black54,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'In Theaters ${movie.releaseDate}',
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.light,
                                    fontSize: 16.h,
                                    fontWeight: FontWeight.w400,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 8.r,
                                        color: Colors.black54,
                                        offset: Offset(0, 2.h),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                      ),
                                    ),
                                    onPressed: () {
                                      // Navigate to booking screen
                                    },
                                    child: Text(
                                      'Get Tickets',
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontSize: 18.h,
                                        color: AppColors.light,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: AppColors.blue,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                      ),
                                    ),
                                    onPressed: () {
                                      // Dispatch event to load trailer
                                      context.read<MovieDetailBloc>().add(
                                        LoadMovieTrailer(movie.id),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.play_arrow,
                                      color: AppColors.blue,
                                      size: 24.h,
                                    ),
                                    label: Text(
                                      'Watch Trailer',
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontSize: 18.h,
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0.w,
                        vertical: 16.h,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.light,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Genres',
                                style: textTheme.headlineLarge?.copyWith(
                                  fontSize: 18.h,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.dark,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 10,
                                runSpacing: 8,
                                children:
                                    [
                                      'science',
                                      'thriller',
                                      'fiction',
                                      'action',
                                    ].map<Widget>((genre) {
                                      final color = _genreColor(genre);
                                      return Chip(
                                        label: Text(
                                          genre,
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: AppColors.light,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        backgroundColor: color,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 4,
                                        ),
                                      );
                                    }).toList(),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Overview',
                                style: textTheme.headlineLarge?.copyWith(
                                  fontSize: 18.h,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.dark,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                movie.overview,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 15.h,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("Something went wrong."));
            }
          },
        ),
      ),
    );
  }
}

Color _genreColor(String genre) {
  switch (genre.toLowerCase()) {
    case 'action':
      return const Color(0xFF4DD0E1);
    case 'thriller':
      return const Color(0xFFE57373);
    case 'science':
      return const Color(0xFF9575CD);
    case 'fiction':
      return const Color(0xFFFFB74D);
    default:
      return const Color(0xFF90A4AE);
  }
}
