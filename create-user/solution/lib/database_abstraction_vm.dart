class DatabaseUpdate {
  final DatabaseUpdateKind kind;
  final String tableName;
  final int rowId;

  DatabaseUpdate(this.kind, this.tableName, this.rowId);
}

enum DatabaseUpdateKind {
  insert,
  update,
  delete,
}

class DatabaseAbstraction {
  void dbExecute(String query, [List<Object?> parameters = const []]) {}

  List<Map<String, Object?>> dbSelect(String query, [List<Object?> parameters = const []]) {
    return [];
  }

  Stream<DatabaseUpdate> get dbUpdates => Stream.empty();

  Future<void> loadDatabaseWithTables(List<String> tables, String dbName) async {}
} 