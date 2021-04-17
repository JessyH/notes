import 'package:flutter/material.dart';

import '../../model/note.dart';
import '../../repository/note_repository.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> notes = [];
  final NoteRepository noteRepository;

  NoteProvider({required this.noteRepository});

  Note getNote(int id) => notes.firstWhere((note) => note.id == id);

  Future<List<Note>> fetchNotes() async {
    try {
      notes.clear();
      notes.addAll(await noteRepository.getNotes());
      notifyListeners();
      return notes;
    } catch (exception) {
      throw Exception('Could not fetch the notes');
    }
  }

  void pinNote(Note note) {
    note.pinned = !note.pinned;
    note.modificationDate = DateTime.now();
    _updateNote(note);
    notifyListeners();
  }

  void deleteNote(Note note) {
    _deleteNote(note.id);
    fetchNotes();
  }

  void saveNote(Note note) {
    _insertNote(note);
    fetchNotes();
  }

  void _insertNote(Note note) async {
    try {
      await noteRepository.insertNote(note);
    } catch (exception) {
      throw Exception('Could not create the note "${note.id}"');
    }
  }

  void _updateNote(Note note) async {
    try {
      await noteRepository.updateNote(note);
    } catch (exception) {
      throw Exception('Could not update the note ${note.id}');
    }
  }

  void _deleteNote(int id) async {
    try {
      await noteRepository.deleteNote(id);
    } catch (exception) {
      throw Exception('Could not delete the note $id');
    }
  }
}
