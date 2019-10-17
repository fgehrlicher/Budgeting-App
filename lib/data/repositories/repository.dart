import 'package:sqflite/sqflite.dart';

abstract class Repository {
  final Database database;

  Repository(this.database);
}
