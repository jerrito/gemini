// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:gemini/src/sql_database/dao/text_dao.dart';
import 'package:gemini/src/sql_database/entities/text.dart';
import 'package:sqflite/sqflite.dart' as sqflite;



part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [TextEntity])
abstract class AppDatabase extends FloorDatabase {
  TextDao get textDao;
}