import 'package:sqlite3/common.dart';

Future<CommonDatabase> openSqliteDb({required String dbName}) async {
  throw UnsupportedError('Sqlite3 is unsupported on this platform.');
}
