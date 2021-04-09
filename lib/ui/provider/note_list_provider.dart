import 'base_provider.dart';
import 'note_provider.dart';
import '../../repository/note_repository.dart';

class NoteListProvider extends BaseProvider {
  final List<NoteProvider> noteProviders = [];
  final NoteRepository noteRepository;

  NoteListProvider({required this.noteRepository});

  void fetchNotes() async {
    try {
      setState(ProviderState.Loading);
      noteProviders.clear();
      final notes = await noteRepository.getNotes();
      noteProviders.addAll(notes.map(
        (note) => NoteProvider(noteRepository: noteRepository, note: note),
      ));
      setState(ProviderState.Success);
    } catch (exception) {
      print(exception);
      setState(ProviderState.Failure);
    }
  }
}
