import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();

  DBHelper.internal();

  factory DBHelper() => _instance;

  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await setDb();

    return _db!;
  }

  static setDb() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, "owltestdb");

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  static void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE form_data(id INTEGER PRIMARY KEY, nama TEXT, alamat TEXT)");
  }
}
