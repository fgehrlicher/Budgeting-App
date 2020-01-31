import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';
import 'package:unnamed_budgeting_app/data/database/persistent_model.dart';

abstract class Repository<T extends PersistentModel> {
  final Future<Database> database;
  final String tableName;
  final T Function(Map<String, dynamic> row) mapperFunc;

  Repository({
    @required this.database,
    @required this.tableName,
    @required this.mapperFunc,
  })  : assert(database != null),
        assert(tableName != null);

  Future<List<T>> getAll({
    int offset,
    int limit,
    String where,
    List<dynamic> whereArgs,
  }) async {
    var db = await database;
    List<T> result = [];
    final List<Map<String, dynamic>> queryResult = await db.query(
      tableName,
      offset: offset,
      limit: limit,
      where: where,
      whereArgs: whereArgs,
    );

    queryResult.forEach((row) {
      result.add(
        mapperFunc(row),
      );
    });

    return result;
  }

  Future<T> get({
    int id,
  }) async {
    var db = await database;
    final List<Map<String, dynamic>> queryResult = await db.query(
      tableName,
    );
    if (queryResult.length == 0) {
      return null;
    }

    return mapperFunc(queryResult[0]);
  }

  void insert(T element) async {
    var db = await database;

    await db.insert(
      tableName,
      element.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void delete(T element) async {
    var db = await database;

    await db.delete(
      tableName,
      where: "${element.idFieldName} = ?",
      whereArgs: [element.idField],
    );
  }

  void insertMultiple(List<T> elements) async {
    var db = await database;
    var batch = db.batch();

    elements.forEach((element) {
      batch.insert(
        tableName,
        element.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });

    await batch.commit(noResult: true);
  }
}
