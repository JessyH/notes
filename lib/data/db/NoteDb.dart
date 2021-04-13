import '../../extensions/bool_ext.dart';

class NoteDb {
  int? id;
  final String title;
  final String body;
  final DateTime creationDate;
  final DateTime modificationDate;
  final bool pinned;

  NoteDb({
    this.id,
    required this.title,
    required this.body,
    required this.creationDate,
    required this.modificationDate,
    required this.pinned,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) idColumn: id,
      titleColumn: title,
      bodyColumn: body,
      creationDateColumn: creationDate.millisecondsSinceEpoch,
      modificationDateColumn: modificationDate.millisecondsSinceEpoch,
      pinnedColumn: pinned.toInt(),
    };
  }

  factory NoteDb.fromMap(Map<String, dynamic> map) {
    return NoteDb(
      id: map[idColumn],
      title: map[titleColumn],
      body: map[bodyColumn],
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map[creationDateColumn]),
      modificationDate:
          DateTime.fromMillisecondsSinceEpoch(map[modificationDateColumn]),
      pinned: map[pinnedColumn] == 1,
    );
  }

  static final String tableName = 'note';
  static final String idColumn = 'id';
  static final String titleColumn = 'title';
  static final String bodyColumn = 'body';
  static final String creationDateColumn = 'creation_date';
  static final String modificationDateColumn = 'modification_date';
  static final String pinnedColumn = 'pinned';

  static String get createTableQuery {
    return '''
      CREATE TABLE ${NoteDb.tableName}(
        ${NoteDb.idColumn} INTEGER PRIMARY KEY NOT NULL, 
        ${NoteDb.titleColumn} TEXT NOT NULL, 
        ${NoteDb.bodyColumn} TEXT NOT NULL, 
        ${NoteDb.creationDateColumn} INTEGER NOT NULL,
        ${NoteDb.modificationDateColumn} INTEGER NOT NULL,
        ${NoteDb.pinnedColumn} INTEGER NOT NULL
      )
    ''';
  }
}
