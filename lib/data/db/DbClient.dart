import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'NoteDb.dart';

class DbClient {
  static Database? _database;
  static final DbClient _instance = DbClient._();
  static final String _dbName = 'note_database.db';
  static final int _dbVersion = 1;

  DbClient._();

  factory DbClient() => _instance;

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    return await openDatabase(
      join(databasesPath, _dbName),
      onCreate: _onCreate,
      version: _dbVersion,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(NoteDb.createTableQuery);
    await _loadFakeNotes(db);
  }

  // TODO: Remove
  _loadFakeNotes(Database db) async {
    await db.insert(
      NoteDb.tableName,
      NoteDb(
        id: 0,
        title: 'Note1',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque porttitor hendrerit nunc, a sodales eros suscipit varius. Nam condimentum vulputate tempor. Aenean mattis ligula mauris, sit amet luctus magna ornare et. Interdum et malesuada fames ac ante ipsum primis in faucibus.',
        creationDate: DateTime.now(),
        modificationDate: DateTime.now(),
        pinned: true,
      ).toMap(),
    );
    await db.insert(
      NoteDb.tableName,
      NoteDb(
        id: 1,
        title: 'Note2',
        body: '- String1 - String2 - String3 - String4',
        creationDate: DateTime.now(),
        modificationDate: DateTime.now(),
        pinned: false,
      ).toMap(),
    );
    await db.insert(
      NoteDb.tableName,
      NoteDb(
        id: 2,
        title: 'Note3',
        body: 'Bla bla bla',
        creationDate: DateTime.now(),
        modificationDate: DateTime.now(),
        pinned: false,
      ).toMap(),
    );
  }
}
