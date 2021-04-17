import 'package:flutter/material.dart';

import '../../model/note.dart';
import '../provider/note_provider.dart';

class ModalBottomSheetViewModel extends ChangeNotifier {
  late final Note note;
  final int id;
  final NoteProvider noteProvider;

  ModalBottomSheetViewModel({
    required this.noteProvider,
    required this.id,
  }) {
    note = noteProvider.getNote(id);
    notifyListeners();
  }

  void pinNote() {
    noteProvider.pinNote(note);
    notifyListeners();
  }

  void deleteNote() {
    noteProvider.deleteNote(note);
  }
}
