import 'base_provider.dart';
import '../../model/note.dart';
import '../../repository/note_repository.dart';

class NoteProvider extends BaseProvider {
  final List<Note> notes = [];
  final NoteRepository noteRepository;

  NoteProvider({required this.noteRepository});

  Note getNote(int id) => notes.firstWhere((note) => note.id == id);

  void fetchNotes() async {
    try {
      setState(ProviderState.Loading);
      notes.clear();
      notes.addAll(await noteRepository.getNotes());
      setState(ProviderState.Success);
    } catch (exception) {
      print(exception);
      setState(ProviderState.Failure);
    }
  }

  void pinNote(Note note) {
    note.pinned = !note.pinned;
    note.modificationDate = DateTime.now();
    _updateNote(note);
  }

  void deleteNote(Note note) {
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
