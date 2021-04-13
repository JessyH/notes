import '../../extensions/bool_ext.dart';

class NoteDb {
  final int id;
  final String title;
  final String body;
  final DateTime creationDate;
  final DateTime modificationDate;
  final bool pinned;

  NoteDb({
    required this.id,
    required this.title,
    required this.body,
    required this.creationDate,
    required this.modificationDate,
    required this.pinned,
  });

  Map<String, dynamic> toMap() {
    return {
      idColumn: id,
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
        ${NoteDb.idColumn} INTEGER PRIMARY KEY, 
        ${NoteDb.titleColumn} TEXT, 
        ${NoteDb.bodyColumn} TEXT, 
        ${NoteDb.creationDateColumn} INTEGER,
        ${NoteDb.modificationDateColumn} INTEGER,
        ${NoteDb.pinnedColumn} INTEGER
      )
    ''';
  }
}
