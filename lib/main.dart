import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/db/app_database.dart';
import 'core/theme/app_theme.dart';
import 'features/movies/data/repositories/movie_repository.dart';
import 'features/movies/presentation/bloc/movie_bloc.dart';
import 'features/movies/presentation/bloc/movie_event.dart';
import 'features/movies/presentation/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app.db').build();
  final repo = MovieRepository(database);
  runApp(
    RepositoryProvider<MovieRepository>.value(
      value: repo,
      child: MovieApp(repository: repo),
    ),
  );
}

class MovieApp extends StatelessWidget {
  final MovieRepository repository;

  const MovieApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        title: 'Movie Booking App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: BlocProvider(
          create: (_) => MovieBloc(repository)..add(LoadMovies()),
          child: const DashboardScreen(),
        ),
      ),
    );
  }
}
