import 'base_provider.dart';
import '../../model/note.dart';
import '../../repository/note_repository.dart';

class NoteListProvider extends BaseProvider {
  final List<Note> _notes = [];
  final NoteRepository noteRepository;

  NoteListProvider({required this.noteRepository});

  List<Note> get notes => _notes;

  void fetchNotes() async {
    try {
      setState(ProviderState.Loading);
      _notes.clear();
      _notes.addAll(await noteRepository.getNotes());
      setState(ProviderState.Success);
    } catch (exception) {
      print(exception);
      setState(ProviderState.Failure);
    }
  }
}
