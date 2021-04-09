import '../model/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes();
  Future<Note> getNote(int id);
  Future<Note> updateNote(Note note);
  Future<void> deleteNote(int id);
}