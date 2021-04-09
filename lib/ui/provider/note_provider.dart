import 'base_provider.dart';
import '../../model/note.dart';
import '../../repository/note_repository.dart';

class NoteProvider extends BaseProvider {
  final Note note;
  final NoteRepository noteRepository;

  NoteProvider({
    required this.noteRepository,
    required this.note,
  });

  void pinNote() {
    note.pinned = !note.pinned;
    note.modificationDate = DateTime.now();
    _updateNote(note);
  }

  void deleteNote() {
    _deleteNote(note.id);
  }

  void _updateNote(Note note) async {
    try {
      await noteRepository.updateNote(note);
      setState(ProviderState.Success);
    } catch (exception) {
      print(exception);
      setState(ProviderState.Failure);
    }
  }

  void _deleteNote(int id) async {
    try {
      await noteRepository.deleteNote(id);
      setState(ProviderState.Success);
    } catch (exception) {
      print(exception);
      setState(ProviderState.Failure);
    }
  }
}
