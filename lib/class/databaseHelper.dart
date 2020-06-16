import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'studentDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'students';
  static final _columnId = 'id';
  static final String _column1Name = 'fName';
  static final String _column2Name = 'lName';
  static final String _column3Name = 'batch';
  

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $_tableName ($_columnId INTEGER PRIMARY KEY,
      $_column1Name  TEXT NOT NULL,
      $_column2Name TEXT NOT NULL,
      $_column3Name TEXT NOT NULL)

      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;

    String fName = row['fName'];
    String lName = row['lName'];
    String batch = row['batch'];
    return await db.update(_tableName, row,
        where: ' $_column1Name = ? $_column2Name = ? $_column3Name = ',
        whereArgs: [fName, lName, batch]);
  }

  Future<int> delete(String fName, String lName, String batch) async {
    Database db = await instance.database;
    return await db.delete(_tableName,
        where: '$_column1Name = ? $_column2Name = ? $_column3Name = ?',
        whereArgs: [fName, lName, batch]);
  }
}
