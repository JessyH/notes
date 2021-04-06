import 'package:flutter/material.dart';

import 'note_page.dart';
import '../model/note.dart';
import '../app_router.dart';

class NoteListItem extends StatelessWidget {
  final Note note;

  NoteListItem({
    required Key key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.title),
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.noteRoute,
        arguments: NotePageArguments(note.id),
      ),
    );
  }
}
