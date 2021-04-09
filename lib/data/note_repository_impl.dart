import '../model/note.dart';
import '../repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final notes = [
    Note(
      id: 1,
      title: 'Note 1',
      body:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque porttitor hendrerit nunc, a sodales eros suscipit varius. Nam condimentum vulputate tempor. Aenean mattis ligula mauris, sit amet luctus magna ornare et. Interdum et malesuada fames ac ante ipsum primis in faucibus.',
      pinned: true,
    ),
    Note(
      id: 2,
      title: 'Note 2',
      body: '- String1 - String2 - String3 - String4',
    ),
    Note(
      id: 3,
      title: 'Note 3',
      body: 'Bla bla bla',
    ),
  ];

  @override
  Future<List<Note>> getNotes() async {
    return notes;
  }

  @override
  Future<Note> getNote(int id) async {
    return notes.firstWhere((note) => note.id == id);
  }

  @override
  Future<Note> updateNote(Note newNote) async {
    var index = notes.indexWhere((note) => note.id == newNote.id);
    notes[index] = newNote;
    return notes[index];
  }

  @override
  Future<void> deleteNote(int id) async {
    notes.removeWhere((note) => note.id == id);
  }
}
