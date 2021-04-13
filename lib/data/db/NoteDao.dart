import 'package:sqflite/sqlite_api.dart';

import 'DbClient.dart';
import 'NoteDb.dart';

class NoteDao {
  Future<List<NoteDb>> getAll() async {
    final Database db = await DbClient().db;
    final maps = await db.query(NoteDb.tableName);
    return List.generate(maps.length, (index) => NoteDb.fromMap(maps[index]));
  }

  Future<NoteDb> getById(int id) async {
    final Database db = await DbClient().db;
    final maps = await db.query(
      NoteDb.tableName,
      where: '${NoteDb.idColumn} = ?',
      whereArgs: [id],
    );
    return NoteDb.fromMap(maps.first);
  }

  Future<int> insert(NoteDb noteDb) async {
    final Database db = await DbClient().db;
    return await db.insert(
      NoteDb.tableName,
      noteDb.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(NoteDb noteDb) async {
    final Database db = await DbClient().db;
    await db.update(
      NoteDb.tableName,
      noteDb.toMap(),
      where: '${NoteDb.idColumn} = ?',
      whereArgs: [noteDb.id],
    );
  }

  Future<void> delete(int id) async {
    final Database db = await DbClient().db;
    await db.delete(
      NoteDb.tableName,
      where: '${NoteDb.idColumn} = ?',
      whereArgs: [id],
    );
  }
}
