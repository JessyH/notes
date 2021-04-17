import 'package:flutter/material.dart';

import '../../model/note.dart';
import '../provider/note_provider.dart';

class NotePageViewModel extends ChangeNotifier {
  late final Note note;
  final int? id;
  final NoteProvider noteProvider;

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  NotePageViewModel({
    required this.noteProvider,
    this.id,
  }) {
    note = (id == null) ? Note.empty() : noteProvider.getNote(id!);
    _initTextControllers();
    notifyListeners();
  }

  void saveNote() {
    // validate
    if (note.id != Note.defaultId) {
      // update
    } else {
      // insert
    }
  }

  void pinNote() {
    noteProvider.pinNote(note);
    notifyListeners();
  }

  void _initTextControllers() {
    titleController.text = note.title;
    bodyController.text = note.body;
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}
