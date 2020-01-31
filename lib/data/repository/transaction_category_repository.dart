import 'package:sqflite/sqflite.dart';
import 'package:unnamed_budgeting_app/data/repository/repository.dart';
import 'package:unnamed_budgeting_app/domain/models/transaction_category.dart';
import 'package:meta/meta.dart';

class TransactionCategoryRepository extends Repository<TransactionCategory> {
  TransactionCategoryRepository({
    @required Future<Database> database,
  }) : super(
          database: database,
          tableName: TransactionCategory.TABLE_NAME,
          mapperFunc: _parseQueryResult,
        );

  static TransactionCategory _parseQueryResult(
    Map<String, dynamic> queryResult,
  ) =>
      TransactionCategory.fromMap(queryResult);
}
