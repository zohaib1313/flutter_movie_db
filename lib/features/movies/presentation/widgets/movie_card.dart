import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/features/moviedetail/presenstation/bloc/movie_detail_bloc.dart';
import 'package:movie_booking_app/features/moviedetail/presenstation/screens/movie_detail_screen.dart';

import '../../data/models/movie.dart';
import '../../data/repositories/movie_repository.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => MovieDetailBloc(
                RepositoryProvider.of<MovieRepository>(context),
              ),
              child: MovieDetailScreen(movieId: movie.id),
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error, size: 50),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black45,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Text(
                movie.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
