import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../features/movies/data/models/movie.dart';
import 'movie_dao.dart';

part 'app_database.g.dart';

@Database(version: 2, entities: [Movie])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
}
