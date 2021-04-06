import '../model/note.dart';
import '../repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final notes = [
    Note(id: 1, title: 'Note 1', creationDate: DateTime.now(), modificationDate: DateTime.now(), pinned: true),
    Note(id: 2, title: 'Note 2', creationDate: DateTime.now(), modificationDate: DateTime.now(), pinned: false),
    Note(id: 3, title: 'Note 3', creationDate: DateTime.now(), modificationDate: DateTime.now(), pinned: false),
  ];

  @override
  Future<Note> getNote(int id) async {
    return notes.firstWhere((note) => note.id == id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return notes;
  }
}
