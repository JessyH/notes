import '../data/db/NoteDao.dart';
import '../data/db/NoteDb.dart';
import '../data/db/NoteDbMapper.dart';
import '../model/note.dart';
import '../repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final NoteDao noteDao;

  NoteRepositoryImpl({required this.noteDao});

  @override
  Future<List<Note>> getNotes() async {
    final List<NoteDb> notesDb = await noteDao.getAll();
    return notesDb
        .map((noteDb) => NoteDbMapper.from(noteDb))
        .toList(growable: false);
  }

  @override
  Future<Note> getNote(int id) async {
    final NoteDb noteDb = await noteDao.getById(id);
    return NoteDbMapper.from(noteDb);
  }

  @override
  Future<void> updateNote(Note newNote) async {
    final NoteDb noteDb = NoteDbMapper.to(newNote);
    await noteDao.update(noteDb);
  }

  @override
  Future<void> deleteNote(int id) async {
    await noteDao.delete(id);
  }
}
