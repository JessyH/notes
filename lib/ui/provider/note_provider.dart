import 'base_provider.dart';
import '../../model/note.dart';
import '../../repository/note_repository.dart';

class NoteProvider extends BaseProvider {
  late final Note _note;
  final NoteRepository noteRepository;

  NoteProvider({required this.noteRepository});

  Note get note => _note;

  void fetchNote(int id) async {
    try {
      setState(ProviderState.Loading);
      _note = await noteRepository.getNote(id);
      setState(ProviderState.Success);
    } catch (exception) {
      print(exception);
      setState(ProviderState.Failure);
    }
  }
}
