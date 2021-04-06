import '../model/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes();
  Future<Note> getNote(int id);
}