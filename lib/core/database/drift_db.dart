import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'drift_db.g.dart';

@DataClassName('CartItemEntity')
class CartItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get price => integer()();
  IntColumn get count => integer().withDefault(const Constant(1))();
  TextColumn get size => text()();
  TextColumn get photo => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DriftDatabase(tables: [CartItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'lichi_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
