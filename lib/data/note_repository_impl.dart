import '../model/note.dart';
import '../repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final notes = [
    Note(id: 1, title: 'Note 1'),
    Note(id: 2, title: 'Note 2'),
    Note(id: 3, title: 'Note 3'),
  ];

  @override
  Future<Note> getNote(int id) async {
    throw notes.firstWhere((note) => note.id == id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return notes;
  }
}
