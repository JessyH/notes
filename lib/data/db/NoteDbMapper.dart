import 'NoteDb.dart';
import '../../model/note.dart';

class NoteDbMapper {
  static Note from(NoteDb noteDb) {
    return Note(
      id: noteDb.id!,
      title: noteDb.title,
      body: noteDb.body,
      creationDate: noteDb.creationDate,
      modificationDate: noteDb.modificationDate,
      pinned: noteDb.pinned,
    );
  }

  static NoteDb to(Note note) {
    return NoteDb(
      id: note.id,
      title: note.title,
      body: note.body,
      creationDate: note.creationDate,
      modificationDate: note.modificationDate,
      pinned: note.pinned,
    );
  }
}
